# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap
pin 'application'
pin_all_from 'app/javascript/src', under: 'src'
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin '@hotwired/turbo-rails', to: '@hotwired--turbo-rails.js' # @8.0.12
pin '@hotwired/turbo', to: '@hotwired--turbo.js' # @8.0.12
pin '@rails/actioncable/src', to: '@rails--actioncable--src.js' # @8.0.200

pin '@hotwired/stimulus', to: '@hotwired--stimulus.js' # @3.2.2
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin '@stimulus-components/clipboard', to: '@stimulus-components--clipboard.js' # @5.0.0
pin '@stimulus-components/popover', to: '@stimulus-components--popover.js' # @7.0.0
pin 'tailwindcss-stimulus-components' # @6.1.3
pin 'stimulus-textarea-autogrow' # @4.1.0
pin 'debounce' # @2.2.0
pin 'throttleit' # @2.1.0
pin '@fortawesome/fontawesome-svg-core', to: '@fortawesome--fontawesome-svg-core.js' # @6.7.2
pin '@fortawesome/free-solid-svg-icons', to: '@fortawesome--free-solid-svg-icons.js' # @6.7.2
pin '@fortawesome/free-brands-svg-icons', to: '@fortawesome--free-brands-svg-icons.js' # @6.7.2
pin '@codemirror/view', to: '@codemirror--view.js' # @6.36.2
pin '@codemirror/state', to: '@codemirror--state.js' # @6.5.2
pin '@marijn/find-cluster-break', to: '@marijn--find-cluster-break.js' # @1.0.2
pin 'style-mod' # @4.1.2
pin 'w3c-keyname' # @2.2.8
pin '@codemirror/commands', to: '@codemirror--commands.js' # @6.8.0
pin '@codemirror/language', to: '@codemirror--language.js' # @6.10.8
pin '@lezer/common', to: '@lezer--common.js' # @1.2.3
pin '@lezer/highlight', to: '@lezer--highlight.js' # @1.2.1
pin '@codemirror/lang-yaml', to: '@codemirror--lang-yaml.js' # @6.1.2
pin '@lezer/lr', to: '@lezer--lr.js' # @1.4.2
pin '@lezer/yaml', to: '@lezer--yaml.js' # @1.0.3
pin 'thememirror' # @2.0.1
# how to get it:
# bin/importmap pin tom-select/dist/js/tom-select.complete.min.js
# mv vendor/javascript/tom-select--dist--js--tom-select.complete.min.js.js vendor/javascript/tom-select.js
pin 'tom-select' # @2.4.3
pin '@floating-ui/dom', to: '@floating-ui--dom.js' # @1.6.13
pin '@floating-ui/core', to: '@floating-ui--core.js' # @1.6.9
pin '@floating-ui/utils', to: '@floating-ui--utils.js' # @0.2.9
pin '@floating-ui/utils/dom', to: '@floating-ui--utils--dom.js' # @0.2.9
pin 'crelt' # @1.0.6
