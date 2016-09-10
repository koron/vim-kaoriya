scriptencoding utf-8
redir! > version-interfaces.out

perl << END
VIM::Msg("Perl: $^V")
END

py << END
import platform
print('Python: ' + platform.python_version())
END

py3 << END
import platform
print('Python3: ' + platform.python_version())
END

ruby << END
print "Ruby: #{RUBY_VERSION}"
END

redir END
quit!
