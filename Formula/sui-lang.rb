class SuiLang < Formula
  desc "A programming language optimized for LLM code generation"
  homepage "https://github.com/TakatoHonda/sui-lang"
  url "https://github.com/TakatoHonda/sui-lang/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "1820d6c483b7e7bb7ada2f791c9f5cab2b7eb7ea2bca0a26571ebb7b394cce5b"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Install Python files
    libexec.install "sui.py", "sui2py.py", "py2sui.py"
    libexec.install "repl"
    
    # Create wrapper scripts
    (bin/"sui").write <<~EOS
      #!/bin/bash
      exec "#{Formula["python@3.11"].opt_bin}/python3.11" "#{libexec}/sui.py" "$@"
    EOS
    
    (bin/"sui2py").write <<~EOS
      #!/bin/bash
      exec "#{Formula["python@3.11"].opt_bin}/python3.11" "#{libexec}/sui2py.py" "$@"
    EOS
    
    (bin/"py2sui").write <<~EOS
      #!/bin/bash
      exec "#{Formula["python@3.11"].opt_bin}/python3.11" "#{libexec}/py2sui.py" "$@"
    EOS
    
    # Install examples
    pkgshare.install "examples"
    pkgshare.install "prompts"
  end

  test do
    # Test interpreter
    (testpath/"test.sui").write <<~EOS
      = g0 42
      . g0
    EOS
    assert_equal "42\n", shell_output("#{bin}/sui #{testpath}/test.sui")
    
    # Test fibonacci
    (testpath/"fib.sui").write <<~EOS
      # 0 1 {
      < v0 a0 2
      ! v1 v0
      ? v1 1
      ^ a0
      : 1
      - v2 a0 1
      $ v3 0 v2
      - v4 a0 2
      $ v5 0 v4
      + v6 v3 v5
      ^ v6
      }
      = g0 10
      $ g1 0 g0
      . g1
    EOS
    assert_equal "55\n", shell_output("#{bin}/sui #{testpath}/fib.sui")
  end
end

