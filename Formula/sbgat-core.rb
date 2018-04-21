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
  url "https://github.com/bbercovici/SBGAT/archive/1.04.6.tar.gz"
  sha256 "ed9a6073b7c33762a95f8fc7ba3f68b2048fce2684ea1c947a1c472aa12cb327"

  # Options
  option "with-gcc", "On Mac, will attempt to compile SbgatCore with gcc from the Homebrew Cellar "
  option 'with-qt', 'Will install Qt and the proper version of VTK to enable use of SbgatGui'

  # Dependencies
  depends_on "cmake" 
  depends_on "bbercovici/self/rbk" 
  depends_on "bbercovici/self/sharmlib" 
  depends_on "bbercovici/self/yorplib"
  depends_on "qt" if build.with? "qt"
  depends_on "bbercovici/self/vtk" if  build.with? "qt"
  depends_on "vtk" if  !build.with? "qt"

  def install

    # Compile and install SbgatCore
    Dir.chdir("SbgatCore") do

    if build.with? "gcc"
      system "cmake . -DBREW:BOOL=TRUE -DUSE_GCC:BOOL=TRUE" 
    else
      system "cmake . -DBREW:BOOL=TRUE" 
    end

    system "make -j"

    include.install "include/SbgatCore"
    share.install "SbgatCore"
    lib.install "libSbgatCore.dylib"
    
  end

    prefix.install "Tests/"

  end

end
