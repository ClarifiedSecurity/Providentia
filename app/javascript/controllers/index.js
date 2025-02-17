// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);

import { Dropdown, Modal } from "tailwindcss-stimulus-components";
import Clipboard from "@stimulus-components/clipboard";
import TextareaAutogrow from "stimulus-textarea-autogrow";

application.register("dropdown", Dropdown);
application.register("modal", Modal);
application.register("clipboard", Clipboard);
application.register("textarea-autogrow", TextareaAutogrow);
