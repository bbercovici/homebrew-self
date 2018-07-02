# OrbitConversions.rb
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

class OrbitConversions < Formula
  desc "A collection of orbit conversion routines"
  homepage "https://github.com/bbercovici/OrbitConversions"
  url "https://github.com/bbercovici/OrbitConversions/archive/1.0.1.tar.gz"
  sha256 "795cf5b4c959a27ef96d2433a889e2935c9586c27e77779ec9eb9bed7dbfa426"

  option "without-gcc", "Will not attempt to find an OMP-compliant GCC compiler in Homebrew's Cellar"
  depends_on "cmake" => :build
  depends_on "rbk" => :build

  def install

    # Compile
    if build.without? "gcc"
      system "cmake . -DBREW:BOOL=TRUE" 
    else
      system "cmake . -DBREW:BOOL=TRUE -DUSE_GCC:BOOL=TRUE" 
    end

    system "make -j"


    # Create symlink to library
    lib.install "libOrbitConversions.dylib"
    include.install "include/OrbitConversions"
    share.install "share/OrbitConversions"
    prefix.install "Tests/"


  end

end
