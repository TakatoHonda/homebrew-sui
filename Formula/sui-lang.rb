class SuiLang < Formula
  desc "A programming language optimized for LLM code generation"
  homepage "https://github.com/TakatoHonda/sui-lang"
  url "https://github.com/TakatoHonda/sui-lang/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "f9b2684a4f41ea1dacd63444d403602230495d4a5d2bbdc77aeac758a49c964f"
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

