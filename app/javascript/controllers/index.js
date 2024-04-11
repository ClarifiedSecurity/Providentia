import { application } from "./application";
import { registerControllers } from "stimulus-vite-helpers";

const controllers = import.meta.glob("./**/*_controller.js", { eager: true });
registerControllers(application, controllers);

import { Dropdown, Modal } from "tailwindcss-stimulus-components";
import Clipboard from "stimulus-clipboard";
import TextareaAutogrow from "stimulus-textarea-autogrow";

application.register("dropdown", Dropdown);
application.register("modal", Modal);
application.register("clipboard", Clipboard);
application.register("textarea-autogrow", TextareaAutogrow);
