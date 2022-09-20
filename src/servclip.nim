import std/asyncdispatch
from std/strformat import fmt
from std/strutils import parseInt
from std/uri import decodeUrl

import pkg/jester
when defined unix:
  from pkg/nimclipboard/libclipboard import clipboard_new, clipboard_text,
                                            clipboard_set_text
elif defined windows:
  import pkg/cliptomania except set_text
from pkg/bluesoftcosmos import Product, getProduct

when defined unix:
  var clip = clipboard_new(nil)
  template get_text(x: untyped): string =
    $x.clipboard_text
  template set_text(x: untyped; s: string): bool =
    x.clipboard_set_text cstring s
else:
  template set_text(x: untyped; s: string): bool =
    cliptomania.set_text(x, s)
    true

routes:
  get "/get":
    resp clip.get_text
  get "/set/text/@text":
    let text = decodeUrl @"text"
    if not clip.set_text text:
      resp "Cannot set clipboard text"
    else:
      echo fmt"Edited clipboard to `{text}`"
      resp text
  get "/set/barcode/@code":
    var
      code = @"code"
      barcode: int64 = -1
      error = ""
    try:
      barcode = parseInt code
    except ValueError:
      error = "Barcode is not a integer"
    block:
      if barcode != -1:
        var data: Product
        try:
          data = await getProduct barcode
        except: discard
        if data.name.len > 0:
          let text = fmt"{barcode},{data.name}"
          if not clip.set_text text:
            error = "Cannot put barcode data in clipboard"
          else:
            echo fmt"Edited clipboard to `{text}`"
            resp $barcode
          break
        else:
          error = "Cannot get barcode data"
    if not clip.set_text code:
      resp "Cannot put barcode in clipboard"
    else:
      resp error
