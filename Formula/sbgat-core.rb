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
  url "https://github.com/bbercovici/SBGAT/archive/1.05.2.tar.gz"
  sha256 "db40fa8a6f74273e330212d641cb2fec449ca2f6f9a7a2b6176a9e2439903ca9"

  # Options
  option "without-gcc", "Will not attempt to find an OMP-compliant GCC compiler in Homebrew's Cellar"

  # Dependencies
  depends_on "cmake" 
  depends_on "bbercovici/self/rbk" 
  depends_on "bbercovici/self/sharmlib" 
  depends_on "bbercovici/self/yorplib"
  depends_on "vtk"
  
  def install

    # Compile and install SbgatCore
    Dir.chdir("SbgatCore") do

      if build.without? "gcc"
        system "cmake . -DBREW:BOOL=TRUE" 
      else
        system "cmake . -DBREW:BOOL=TRUE -DUSE_GCC:BOOL=TRUE" 
      end

      system "make -j"

      include.install "include/SbgatCore"
      include.install "include/nlohmann"

      share.install "SbgatCore"
      lib.install "libSbgatCore.dylib"

    end

    prefix.install "Tests/"

  end

end
