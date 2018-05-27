# yorplib.rb
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

class Yorplib < Formula
  desc "A library for the computation of the Fourier decomposition of YORP forces and moments"
  homepage "https://github.com/bbercovici/YORPLib"
  url "https://github.com/bbercovici/YORPLib/archive/1.0.9.tar.gz"
  sha256 "f6f42ce1ad8efff94e1884d9182e67e33a78ede449ca265da8f441e14cfd3a09"


  option "without-gcc", "Will not attempt to find an OMP-compliant GCC compiler in Homebrew's Cellar"
  depends_on "cmake" => :build

  def install

    # Compile
    if build.without? "gcc"
      system "cmake . -DBREW:BOOL=TRUE" 
    else
      system "cmake . -DBREW:BOOL=TRUE -DUSE_GCC:BOOL=TRUE" 
    end

    system "make -j"


    # Create symlink to library
    lib.install "libYORPLib.dylib"
    include.install "include/YORPLib"
    share.install "share/YORPLib"
    prefix.install "Example/"


  end

end
