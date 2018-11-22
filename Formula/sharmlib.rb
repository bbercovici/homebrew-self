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

class Sharmlib < Formula
  desc "A library of functions computing the spherical harmonics expansion of the gravity acceleration caused by a constant density polyhedron."
  homepage "https://github.com/bbercovici/SHARMLib"
  url "https://github.com/bbercovici/SHARMLib/archive/1.0.8.tar.gz"
  sha256 "8e7900daad724cc4d142131d4391bd24fe8556fc8a9515d37144d2373da49177"

  depends_on "cmake"

  def install

    # Compile
    system "cmake . -DBREW:BOOL=TRUE" 
    system "make -j"

    # Create symlink to library
    lib.install "libSHARMLib.dylib"
    include.install "include/SHARMLib.hpp"
    share.install "SHARMLib/"
    prefix.install "Tests/"

  end


end
