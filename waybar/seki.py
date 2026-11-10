#!/usr/bin/env python3
"""Waybar modules for seki.

Usage: seki.py workspaces|title|layout  streams one module from `sekictl subscribe`.
       seki.py scroll up|down           focuses the next or previous workspace.
"""
import html
import json
import signal
import subprocess
import sys

BACKGROUND_ALT = "#373B41"
PRIMARY = "#F0C674"
DISABLED = "#707880"
TITLE_LENGTH = 60
# Pango paints backgrounds over the line height, so this fills the bar like polybar.
WORKSPACE_LINE_HEIGHT = "2.1"


def escape(text):
    return html.escape(text, quote=True)


def focused_workspace(snapshot):
    return next((w for w in snapshot.get("workspaces", []) if w["focused"]), None)


def workspaces(snapshot):
    labels = []
    for w in snapshot.get("workspaces", []):
        if w["focused"]:
            attributes = f' background="{BACKGROUND_ALT}" underline="single" underline_color="{PRIMARY}"'
        elif w["visible"]:
            attributes = f' background="{BACKGROUND_ALT}"'
        elif w["occupied"]:
            attributes = ""
        else:
            attributes = f' foreground="{DISABLED}"'
        labels.append(f"<span{attributes}> {escape(w['tag'])} </span>")
    return {"text": f'<span line_height="{WORKSPACE_LINE_HEIGHT}">{"".join(labels)}</span>'}


def title(snapshot):
    text = snapshot.get("focused_title") or ""
    if len(text) > TITLE_LENGTH:
        text = text[:TITLE_LENGTH] + "..."
    return {"text": escape(text)}


def layout(snapshot):
    focused = focused_workspace(snapshot)
    return {"text": escape(focused["layout"]) if focused else ""}


def neighbour(snapshot, step):
    tags = [w["tag"] for w in snapshot.get("workspaces", [])]
    focused = focused_workspace(snapshot)
    if focused is None:
        return None
    return tags[(tags.index(focused["tag"]) + step) % len(tags)]


MODULES = {"workspaces": workspaces, "title": title, "layout": layout}


def stream(render):
    def stop(_signal, _frame):
        raise KeyboardInterrupt

    signal.signal(signal.SIGTERM, stop)
    with subprocess.Popen(["sekictl", "subscribe"], stdout=subprocess.PIPE,
                          text=True, encoding="utf-8") as process:
        try:
            for line in process.stdout:
                snapshot = json.loads(line)["result"]["snapshot"]
                print(json.dumps(render(snapshot), ensure_ascii=True), flush=True)
        except (BrokenPipeError, KeyboardInterrupt):
            pass
        finally:
            signal.signal(signal.SIGTERM, signal.SIG_IGN)
            process.terminate()
            process.wait()


def scroll(direction):
    reply = subprocess.run(["sekictl", "snapshot"], capture_output=True, text=True,
                           encoding="utf-8", check=True)
    tag = neighbour(json.loads(reply.stdout)["result"]["snapshot"], 1 if direction == "down" else -1)
    if tag is not None:
        subprocess.run(["sekictl", "workspace", tag], stdout=subprocess.DEVNULL, check=True)


def main(argv):
    if len(argv) == 2 and argv[1] in MODULES:
        stream(MODULES[argv[1]])
    elif len(argv) == 3 and argv[1] == "scroll" and argv[2] in ("up", "down"):
        scroll(argv[2])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
