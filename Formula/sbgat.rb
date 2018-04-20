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

class Sbgat < Formula

  desc "The implementation of the Small Bodies Geophysical Analysis Tool "
  homepage "https://github.com/bbercovici/SBGAT"
  url "https://github.com/bbercovici/SBGAT/archive/1.04.6.tar.gz"
  sha256 "55b159965d20fd93168ecbae5bb043dd939bf716cc4e29508bd843a9a6064e33"

  # Dependencies
  depends_on "cmake" 
  depends_on "bbercovici/self/rbk" 
  depends_on "bbercovici/self/sharmlib" 
  depends_on "bbercovici/self/yorplib"
  depends_on "qt"
  depends_on "bbercovici/self/vtk" => ["with-qt"]

  # Options
  option "with-gcc", "On Mac, will attempt to compile Rbk with gcc from the Cellar "

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
  end

    # Compile and install SbgatGui
    Dir.chdir("SbgatGui") do

      home_dir = File.expand_path('~')
      puts home_dir

      if build.with? "gcc"
        system "cmake . -DBREW:BOOL=TRUE -DUSE_GCC:BOOL=TRUE" 
      else
        system "cmake . -DBREW:BOOL=TRUE" 
      end 
      system "make -j"

      bin.install "SbgatGui"

    end


    prefix.install "Tests/"



  end

end
