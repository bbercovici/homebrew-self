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

class SbgatCore < Formula

  desc "The implementation of the Small Bodies Geophysical Analysis Tool"
  homepage "https://github.com/bbercovici/SBGAT"
  url "https://github.com/bbercovici/SBGAT/archive/1.11.1.tar.gz"
  sha256 "aab151b123612ebf437ef3f4eb5e9b39ee7f3efd9e7ef4876e754e75520260e3"

  # Options

  # Dependencies
  depends_on "cmake" 
  depends_on "libomp"
  depends_on "armadillo"
  depends_on "bbercovici/self/rbk" 
  depends_on "bbercovici/self/sharmlib" 
  depends_on "bbercovici/self/yorplib"
  depends_on "bbercovici/self/orbit-conversions"

  depends_on "vtk"
  
  def install

    # Compile and install SbgatCore
    Dir.chdir("SbgatCore") do

      system "cmake . -DBREW:BOOL=TRUE -DOpenMP_CXX_FLAGS='-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include' -DOpenMP_CXX_LIB_NAMES=omp -DOpenMP_omp_LIBRARY=/usr/local/opt/libomp/lib/libomp.dylib" 
      system "make -j"

      include.install "include/SbgatCore"
      include.install "include/nlohmann"

      share.install "SbgatCore"
      lib.install "libSbgatCore.dylib"

    end

    prefix.install "Tests/"

  end

end
