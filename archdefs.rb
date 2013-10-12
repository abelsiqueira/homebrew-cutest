require 'formula'

# CCPForge requires that svn checkouts be done with --username anonymous.
# This should be available in Homebrew by default in the near future.

class AnonymousSubversionDownloadStrategy < SubversionDownloadStrategy
  def quiet_safe_system *args
    super *args + ['--username', 'anonymous']
  end
end

class Archdefs < Formula
  homepage 'http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki'
  head 'http://ccpforge.cse.rl.ac.uk/svn/cutest/archdefs/trunk', :using => AnonymousSubversionDownloadStrategy

  keg_only 'This formula only installs data files'

  def install
    bin.install Dir['bin/*']
    prefix.install Dir['ccompiler*'], Dir['compiler*'], Dir['system*']
    Pathname.new("#{prefix}/archdefs.bashrc").write <<-EOF.undent
      export ARCHDEFS=#{prefix}
    EOF
  end

  def caveats; <<-EOS.undent
    In your ~/.bashrc, add the line
    . #{prefix}/archdefs.bashrc
    EOS
  end
end
