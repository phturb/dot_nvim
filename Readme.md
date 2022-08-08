## Personal NeoVim configuration

### Requirements

- NeoVim >=0.7
- npm

To make it work, there are some additional manual configuration that must be done

First, we need to add to the PATH environment variable the installation directory of the `mason` plugin. Usually it looks like :

```
$HOME/.local/share/nvim/mason/bin
```

### LSP Configuration

List :

- Ruby - Solargraph
- Lua - sumneko_lua
- Typescript/Javascript - tsserver
- Typescript/Javascript - eslint
- Rust - rust_analyzer
- Java - jdtls
- Python - jedi_language_server
- HTML - html
- CSS - jsonls
- Terraform - terraformls
- Bash - bashls
- Go - gopls

#### Java

The java plugins is the one that require the most manual configuration. You need to download the `eclipse.jdt.ls` 
Java Language Server, `lombok` java library, `vscode-java-debug` debugger lugin and `vscode-java-test` testing plugin.

You also need a version of java >= 11 to be able to run the language server.

You need to configure the `JAVA_HOME` path or update the `ftplugin/java.lua` file to point to the right java version.
You also need to update or make sure the path in the `ftplugin/java.lua` file point to the right directory and file version 
for `eclipse.jdt.ls`, `lobok`, `vscode-java-debug` and `vscode-java-test`.

