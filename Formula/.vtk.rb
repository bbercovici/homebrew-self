# MIT License

# Copyright (c) 2018 Benjamin Bercovici

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

class Vtk < Formula

  desc "Toolkit for 3D computer graphics, image processing, and visualization. Modified install options to allow use of QVTKWidget within a Qt application"
  homepage "https://www.vtk.org/"
  url "https://www.vtk.org/files/release/8.1/VTK-8.1.0.tar.gz"
  sha256 "6e269f07b64fb13774f5925161fb4e1f379f4e6a0131c8408c555f6b58ef3cb7"
  revision 1
  head "https://github.com/Kitware/VTK.git"

  bottle do
    sha256 "491015b614d28cd9b9a60fc7150553451bdb58dbc9df870e26672360d8636db6" => :high_sierra
    sha256 "f4f05ff2088b6ab12b8eb40c685e9cb1f3f375ae16d84c269783cedd786e3250" => :sierra
    sha256 "7c874c41cebc5b6d318e30b2ae072a2de5496def96273af90dbabc06f486d009" => :el_capitan
  end

  option "without-python@2", "Build without python2 support"
  option "with-2-threads", "Build vtk with two threads"
  option "with-3-threads", "Build vtk with three threads"
  option "with-4-threads", "Build vtk with four threads"
  option "with-all-threads", "Build vtk with all threads available on the build platform"


  deprecated_option "without-python" => "without-python@2"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "fontconfig"
  depends_on "hdf5"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "netcdf"
  depends_on "python@2" => :recommended
  depends_on "python" => :optional
  depends_on "qt" 
  depends_on "pyqt"

  needs :cxx11

  def install

    puts "Installing VTK with Qt linking"

    # Choose the number of threads to dedicate to the build
    # Default number of threads is 1

    if build.with? "2-threads"
      build_threads = "-j2"
    elsif build.with? "3-threads"
      build_threads = "-j3"
    elsif build.with? "4-threads"
      build_threads = "-j4"
    elsif build.with? "all-threads"
      build_threads = "-j"
    else
      build_threads = ""
    end

    unix_makefiles = "Unix Makefiles" 
    args = std_cmake_args + %W[
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTING=OFF
      -DCMAKE_INSTALL_NAME_DIR:STRING=#{lib}
      -DCMAKE_INSTALL_RPATH:STRING=#{lib}
      -DModule_vtkInfovisBoost=ON
      -DModule_vtkInfovisBoostGraphAlgorithms=ON
      -DModule_vtkRenderingFreeTypeFontConfig=ON
      -DVTK_REQUIRED_OBJCXX_FLAGS=''
      -DVTK_USE_COCOA=ON
      -DVTK_USE_SYSTEM_EXPAT=ON
      -DVTK_USE_SYSTEM_HDF5=ON
      -DVTK_USE_SYSTEM_JPEG=ON
      -DVTK_USE_SYSTEM_LIBXML2=ON
      -DVTK_USE_SYSTEM_NETCDF=ON
      -DVTK_USE_SYSTEM_PNG=ON
      -DVTK_USE_SYSTEM_TIFF=ON
      -DVTK_USE_SYSTEM_ZLIB=ON
      -DVTK_WRAP_TCL=ON
      -G#{unix_makefiles} 
      -DVTK_USE_QVTK:BOOL=ON 
      -DVTK_USE_GUISUPPORT:BOOL=ON 
      -DModule_vtkIOExportOpenGL2:BOOL=ON 
      -DVTK_USE_CXX11_FEATURES:BOOL=ON 
      -DVTK_RENDERING_BACKEND:STRING=OpenGL2
    ]

    unless MacOS::CLT.installed?
      # We are facing an Xcode-only installation, and we have to keep
      # vtk from using its internal Tk headers (that differ from OSX's).
      args << "-DTK_INCLUDE_PATH:PATH=#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework/Headers"
      args << "-DTK_INTERNAL_PATH:PATH=#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework/Headers/tk-private"
    end

    mkdir "build" do
      if build.with?("python") && build.with?("python@2")
        # VTK Does not support building both python 2 and 3 versions
        odie "VTK: Does not support building both python 2 and 3 wrappers"
      elsif build.with?("python") || build.with?("python@2")
        python_executable = `which python3`.strip if build.with? "python"
        python_executable = `which python2.7`.strip if build.with? "python@2"

        python_prefix = `#{python_executable} -c 'import sys;print(sys.prefix)'`.chomp
        python_include = `#{python_executable} -c 'from distutils import sysconfig;print(sysconfig.get_python_inc(True))'`.chomp
        python_version = "python" + `#{python_executable} -c 'import sys;print(sys.version[:3])'`.chomp
        py_site_packages = "#{lib}/#{python_version}/site-packages"

        args << "-DVTK_WRAP_PYTHON=ON"
        args << "-DPYTHON_EXECUTABLE='#{python_executable}'"
        args << "-DPYTHON_INCLUDE_DIR='#{python_include}'"
        # CMake picks up the system's python dylib, even if we have a brewed one.
        if File.exist? "#{python_prefix}/Python"
          args << "-DPYTHON_LIBRARY='#{python_prefix}/Python'"
        elsif File.exist? "#{python_prefix}/lib/lib#{python_version}.a"
          args << "-DPYTHON_LIBRARY='#{python_prefix}/lib/lib#{python_version}.a'"
        elsif File.exist? "#{python_prefix}/lib/lib#{python_version}.dylib"
          args << "-DPYTHON_LIBRARY='#{python_prefix}/lib/lib#{python_version}.dylib'"
        else
          odie "No libpythonX.Y.{dylib|a} file found!"
        end
        # Set the prefix for the python bindings to the Cellar
        args << "-DVTK_INSTALL_PYTHON_MODULE_DIR='#{py_site_packages}/'"
      end

      args << "-DVTK_QT_VERSION:STRING=5" << "-DVTK_Group_Qt=ON"
      args << "-DVTK_WRAP_PYTHON_SIP=ON"
      args << "-DSIP_PYQT_DIR='#{Formula["pyqt5"].opt_share}/sip'"


      system "cmake", "..", *args

      system "make #{build_threads}"

      system "make", "install"

    end
  end

  test do
    vtk_include = Dir[opt_include/"vtk-*"].first
    major, minor = vtk_include.match(/.*-(.*)$/)[1].split(".")

    (testpath/"version.cpp").write <<~EOS
    #include <vtkVersion.h>
    #include <assert.h>
    int main(int, char *[]) {
      assert (vtkVersion::GetVTKMajorVersion()==#{major});
      assert (vtkVersion::GetVTKMinorVersion()==#{minor});
      return EXIT_SUCCESS;
    }
    EOS

    system ENV.cxx, "-std=c++11", "version.cpp", "-I#{vtk_include}"
    system "./a.out"
    system "#{bin}/vtkpython", "-c", "exit()"
  end
end