// throttleit@3.0.0 downloaded from https://ga.jspm.io/npm:throttleit@3.0.0/index.js

function e(e,t){if(typeof e!=`function`)throw TypeError(`Expected the first argument to be a \`function\`, got \`${typeof e}\`.`);if(!Number.isFinite(t)||t<0)throw TypeError(`Expected the second argument to be a non-negative finite number, got \`${t}\`.`);let n,r=0,i;return function a(...o){clearTimeout(n);let s=Date.now(),c=t-(s-r);return c<=0?(r=s,i=e.apply(this,o)):n=setTimeout(()=>{r=Date.now(),i=e.apply(this,o)},c),i}}export{e as default};

