LOVE2D 預設只會執行專案根目錄下的 main.lua，它不會自動去子目錄（如 Lesson1、Lesson2）裡面尋找 main.lua。
因此，如果您想要在 VSCode 中直接執行子目錄裡的 main.lua，您需要進行一些設定。
假設你用的延伸模組為 Love2D.config

檔案->喜好設定->設定->延伸模組->Love2D.config
在這裡設定Love2D的路徑，預設為專案根目錄(.)
Pixelbyte › Love2d: Src Dir 預設為 . 改為 src
這樣未來只要您畫面正開著 Lesson1/main.lua，按下 Alt + L 就會直接單獨執行該子目錄！