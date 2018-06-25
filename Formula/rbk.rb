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

class Rbk < Formula
  desc "Implementation of a number of useful rigid body kinematics routines and frame conversion utilities relying on Armadillo."
  homepage "https://github.com/bbercovici/RigidBodyKinematics"
  url "https://github.com/bbercovici/RigidBodyKinematics/archive/1.0.8.tar.gz"
  sha256 "5358e9b316d492fcf9bb25b76788b4573a6daf11d8b721c57fa47da6aa299a78"


  option "without-gcc", "Will not attempt to find an OMP-compliant GCC compiler in Homebrew's Cellar"
  depends_on "cmake" => :build

  def install

    # Compile
    if build.without? "gcc"
      system "cmake . -DBREW:BOOL=TRUE" 
    else
      system "cmake . -DBREW:BOOL=TRUE -DUSE_GCC:BOOL=TRUE" 
    end

    # Compile
    system "make"

    # Create symlink to library
    lib.install "libRigidBodyKinematics.dylib"
    include.install "include/RigidBodyKinematics.hpp"
    share.install "RigidBodyKinematics/"

    # Finishing install
    prefix.install Dir["Examples"]
    prefix.install Dir["Tests"]

  end

end
