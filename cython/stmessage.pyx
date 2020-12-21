#!/usr/bin/python
from Xlib.display import Display
import Xlib
import sys

def scanWindows(window,name):
    children = window.query_tree().children
    for w in children:
        try:
            windowInstance, _ = w.get_wm_class()
            if windowInstance == name:
                try:
                    display.send_event(
                        destination = w,
                        event = Xlib.protocol.event.ClientMessage(
                            window = w,
                            client_type = display.intern_atom("ReloadColors", False),
                            data = (8, ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]))
                            ),
                        event_mask = False,
                        propagate = True,
                    )
                except:
                    print("Unexpected error:", sys.exc_info())
                    raise
            else:
                continue
        except: 
            scanWindows(w, name)

display = Display()
root = display.screen().root
for name in sys.argv[1:]:
    scanWindows(root,name)
