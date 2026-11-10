#!/usr/bin/env python3
import importlib.util
from pathlib import Path
import unittest

spec = importlib.util.spec_from_file_location("seki_bar", Path(__file__).with_name("seki.py"))
bar = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bar)


def workspace(tag, focused=False, visible=False, occupied=False, layout="Tall"):
    return {"tag": tag, "focused": focused, "visible": visible, "occupied": occupied, "layout": layout}


class WorkspacesTest(unittest.TestCase):
    def test_each_state_has_the_polybar_style(self):
        text = bar.workspaces({"workspaces": [
            workspace("term", focused=True, visible=True, occupied=True),
            workspace("emacs", visible=True),
            workspace("Web", occupied=True),
            workspace("4"),
        ]})["text"]
        self.assertEqual(text, "".join([
            '<span line_height="2.1">',
            '<span background="#373B41" underline="single" underline_color="#F0C674"> term </span>',
            '<span background="#373B41"> emacs </span>',
            "<span> Web </span>",
            '<span foreground="#707880"> 4 </span>',
            "</span>",
        ]))

    def test_tags_are_escaped(self):
        text = bar.workspaces({"workspaces": [workspace("<&>")]})["text"]
        self.assertIn(" &lt;&amp;&gt; ", text)


class TitleTest(unittest.TestCase):
    def test_long_titles_are_cut_like_polybar(self):
        self.assertEqual(bar.title({"focused_title": "x" * 61})["text"], "x" * 60 + "...")
        self.assertEqual(bar.title({"focused_title": "x" * 60})["text"], "x" * 60)

    def test_title_is_escaped_after_cutting(self):
        self.assertEqual(bar.title({"focused_title": "a&b"})["text"], "a&amp;b")

    def test_no_focused_window_is_empty(self):
        self.assertEqual(bar.title({"focused_title": None})["text"], "")
        self.assertEqual(bar.title({})["text"], "")


class LayoutTest(unittest.TestCase):
    def test_focused_workspace_layout(self):
        snapshot = {"workspaces": [workspace("1"), workspace("2", focused=True, layout="Mirror <Tall>")]}
        self.assertEqual(bar.layout(snapshot)["text"], "Mirror &lt;Tall&gt;")

    def test_no_focused_workspace_is_empty(self):
        self.assertEqual(bar.layout({"workspaces": []})["text"], "")


class ScrollTest(unittest.TestCase):
    snapshot = {"workspaces": [workspace("1"), workspace("2", focused=True), workspace("3")]}

    def test_steps_wrap_around(self):
        self.assertEqual(bar.neighbour(self.snapshot, 1), "3")
        self.assertEqual(bar.neighbour(self.snapshot, -1), "1")
        self.assertEqual(bar.neighbour(self.snapshot, 2), "1")

    def test_no_focused_workspace_has_no_neighbour(self):
        self.assertIsNone(bar.neighbour({"workspaces": [workspace("1")]}, 1))


if __name__ == "__main__":
    unittest.main()
