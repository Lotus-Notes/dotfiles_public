import Quickshell
import Quickshell.Io

// Standalone host for Omarchy's clipboard overlay. Omarchy's shell loads
// Clipboard.qml as a keepLoaded plugin and toggles it over IPC; this does the
// same so `qs ipc -p ~/.config/quickshell/clipboard call clipboard toggle` matches
// `omarchy-shell shell toggle omarchy.clipboard`.
ShellRoot {
  Clipboard {
    id: clipboard
  }

  IpcHandler {
    target: "clipboard"

    function toggle(): void { clipboard.toggle() }
    function summon(): void { clipboard.open("{}") }
    function hide(): void { clipboard.close() }
  }
}
