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
  url "https://github.com/bbercovici/SBGAT/archive/1.08.1.tar.gz"
  sha256 "7f3ba7597e8147cdbe9de7a25f278dd3ed2a8a9ea12c9c5afa9533f682aa8bd6"

  # Options

  # Dependencies
  depends_on "cmake" 
  depends_on "bbercovici/self/rbk" 
  depends_on "bbercovici/self/sharmlib" 
  depends_on "bbercovici/self/yorplib"
  depends_on "bbercovici/self/orbit-conversions"

  depends_on "vtk"
  
  def install

    # Compile and install SbgatCore
    Dir.chdir("SbgatCore") do

      system "cmake . -DBREW:BOOL=TRUE" 
      system "make -j"

      include.install "include/SbgatCore"
      include.install "include/nlohmann"

      share.install "SbgatCore"
      lib.install "libSbgatCore.dylib"

    end

    prefix.install "Tests/"

  end

end
