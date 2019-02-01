# MIT License

# Copyright (c) 2019 Benjamin Bercovici

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

class Shapeuqlib < Formula
  desc "Implementation of an analytical shape uncertainty and inertia statistics formulation."
  homepage "https://github.com/bbercovici/ShapeUQLib"
  url "https://github.com/bbercovici/ShapeUQLib/archive/1.0.2.tar.gz"
  sha256 "5510982c2465b83281a8038ad42bc97ef1d15fb5b625975b0c274443193bb2a3"

  depends_on "cmake" => :build
  depends_on "armadillo"

  def install

    # Compile
    system "cmake . -DBREW:BOOL=TRUE" 
    system "make"

    # Create symlink to library
    lib.install "libShapeUQLib.dylib"
    include.install "include/ShapeUQLib.hpp"
    share.install "ShapeUQLib/"

  end

end
