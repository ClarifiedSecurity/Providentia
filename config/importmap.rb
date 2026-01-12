# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap
pin 'application'
pin_all_from 'app/javascript/src', under: 'src'
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin '@hotwired/turbo-rails', to: '@hotwired--turbo-rails.js' # @8.0.20
pin '@hotwired/turbo', to: '@hotwired--turbo.js' # @8.0.20
pin '@rails/actioncable/src', to: '@rails--actioncable--src.js' # @8.1.100

pin '@hotwired/stimulus', to: '@hotwired--stimulus.js' # @3.2.2
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin '@stimulus-components/clipboard', to: '@stimulus-components--clipboard.js' # @5.0.0
pin '@stimulus-components/popover', to: '@stimulus-components--popover.js' # @7.0.0
pin '@stimulus-components/dropdown', to: '@stimulus-components--dropdown.js' # @3.0.0
pin '@stimulus-components/dialog', to: '@stimulus-components--dialog.js' # @1.0.1
pin 'stimulus-textarea-autogrow' # @4.1.0
pin 'debounce' # @3.0.0
pin 'throttleit' # @2.1.0
pin '@fortawesome/fontawesome-svg-core', to: '@fortawesome--fontawesome-svg-core.js' # @7.1.0
pin '@fortawesome/free-solid-svg-icons', to: '@fortawesome--free-solid-svg-icons.js' # @7.1.0
pin '@fortawesome/free-brands-svg-icons', to: '@fortawesome--free-brands-svg-icons.js' # @7.1.0
pin '@codemirror/view', to: '@codemirror--view.js' # @6.39.8
pin '@codemirror/state', to: '@codemirror--state.js' # @6.5.3
pin '@marijn/find-cluster-break', to: '@marijn--find-cluster-break.js' # @1.0.2
pin 'style-mod' # @4.1.3
pin 'w3c-keyname' # @2.2.8
pin '@codemirror/commands', to: '@codemirror--commands.js' # @6.10.1
pin '@codemirror/language', to: '@codemirror--language.js' # @6.12.1
pin '@lezer/common', to: '@lezer--common.js' # @1.5.0
pin '@lezer/highlight', to: '@lezer--highlight.js' # @1.2.3
pin '@codemirror/lang-yaml', to: '@codemirror--lang-yaml.js' # @6.1.2
pin '@codemirror/lang-json', to: '@codemirror--lang-json.js' # @6.0.2
pin '@lezer/lr', to: '@lezer--lr.js' # @1.4.5
pin '@lezer/yaml', to: '@lezer--yaml.js' # @1.0.3
pin '@lezer/json', to: '@lezer--json.js' # @1.0.3
pin 'thememirror' # @2.0.1
# how to get it:
# bin/importmap pin tom-select/dist/js/tom-select.complete.min.js
# mv vendor/javascript/tom-select--dist--js--tom-select.complete.min.js.js vendor/javascript/tom-select.js
pin 'tom-select' # @2.4.3
pin '@floating-ui/dom', to: '@floating-ui--dom.js' # @1.7.4
pin '@floating-ui/core', to: '@floating-ui--core.js' # @1.7.3
pin '@floating-ui/utils', to: '@floating-ui--utils.js' # @0.2.10
pin '@floating-ui/utils/dom', to: '@floating-ui--utils--dom.js' # @0.2.10
pin 'stimulus-use' # @0.52.3
pin 'crelt' # @1.0.6
pin 'railsui-stimulus' # @1.1.2
