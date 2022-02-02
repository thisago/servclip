# Changelog

## Version 0.3.2 (01/20/2022)

- Decoded the text content of `GET /set/text/{text}`

---

## Version 0.3.1 (01/20/2022)

- Fixed barcode proccessing fallback

---

## Version 0.3.0 (01/20/2022)

- If no barcode data was found, copy just barcode
- Changed the name separation from ` - ` to `,`

---

## Version 0.2.0 (01/18/2022)

- Print in terminal when clipboard was modified
- Added error 500 when cannot set clipboard
- Changed route `GET /set/{text}` to `GET /set/text/{text}`
- Added route `GET /set/barcode/{code}`
