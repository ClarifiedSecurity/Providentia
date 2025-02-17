// throttleit@2.1.0 downloaded from https://ga.jspm.io/npm:throttleit@2.1.0/index.js

var t=typeof globalThis!=="undefined"?globalThis:typeof self!=="undefined"?self:global;var e={};function throttle(e,o){if(typeof e!=="function")throw new TypeError(`Expected the first argument to be a \`function\`, got \`${typeof e}\`.`);let n;let l=0;return function throttled(...f){clearTimeout(n);const r=Date.now();const a=r-l;const i=o-a;if(i<=0){l=r;e.apply(this||t,f)}else n=setTimeout((()=>{l=Date.now();e.apply(this||t,f)}),i)}}e=throttle;var o=e;export{o as default};

