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
  url "https://github.com/bbercovici/RigidBodyKinematics/archive/1.0.11.tar.gz"
  sha256 "24048988fc4af3014c83f811a104f497e4b8ecac8ab295e65bb87ab01623c5bb"

  depends_on "cmake" => :build
  depends_on "armadillo"

  def install

    # Compile
    system "cmake . -DBREW:BOOL=TRUE" 
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
