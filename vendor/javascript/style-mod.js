// style-mod@4.1.2 downloaded from https://ga.jspm.io/npm:style-mod@4.1.2/src/style-mod.js

const e="ͼ";const t=typeof Symbol=="undefined"?"__"+e:Symbol.for(e);const s=typeof Symbol=="undefined"?"__styleSet"+Math.floor(Math.random()*1e8):Symbol("styleSet");const l=typeof globalThis!="undefined"?globalThis:typeof window!="undefined"?window:{};class StyleModule{constructor(e,t){this.rules=[];let{finish:s}=t||{};function splitSelector(e){return/^@/.test(e)?[e]:e.split(/,\s*/)}function render(e,t,l,n){let i=[],o=/^@(\w+)\b/.exec(e[0]),r=o&&o[1]=="keyframes";if(o&&t==null)return l.push(e[0]+";");for(let s in t){let n=t[s];if(/&/.test(s))render(s.split(/,\s*/).map((t=>e.map((e=>t.replace(/&/,e))))).reduce(((e,t)=>e.concat(t))),n,l);else if(n&&typeof n=="object"){if(!o)throw new RangeError("The value of a property ("+s+") should be a primitive value.");render(splitSelector(s),n,i,r)}else n!=null&&i.push(s.replace(/_.*/,"").replace(/[A-Z]/g,(e=>"-"+e.toLowerCase()))+": "+n+";")}(i.length||r)&&l.push((!s||o||n?e:e.map(s)).join(", ")+" {"+i.join(" ")+"}")}for(let t in e)render(splitSelector(t),e[t],this.rules)}getRules(){return this.rules.join("\n")}static newName(){let s=l[t]||1;l[t]=s+1;return e+s.toString(36)}static mount(e,t,l){let n=e[s],i=l&&l.nonce;n?i&&n.setNonce(i):n=new StyleSet(e,i);n.mount(Array.isArray(t)?t:[t],e)}}let n=new Map;class StyleSet{constructor(e,t){let l=e.ownerDocument||e,i=l.defaultView;if(!e.head&&e.adoptedStyleSheets&&i.CSSStyleSheet){let t=n.get(l);if(t)return e[s]=t;this.sheet=new i.CSSStyleSheet;n.set(l,this)}else{this.styleTag=l.createElement("style");t&&this.styleTag.setAttribute("nonce",t)}this.modules=[];e[s]=this}mount(e,t){let s=this.sheet;let l=0,n=0;for(let t=0;t<e.length;t++){let i=e[t],o=this.modules.indexOf(i);if(o<n&&o>-1){this.modules.splice(o,1);n--;o=-1}if(o==-1){this.modules.splice(n++,0,i);if(s)for(let e=0;e<i.rules.length;e++)s.insertRule(i.rules[e],l++)}else{while(n<o)l+=this.modules[n++].rules.length;l+=i.rules.length;n++}}if(s)t.adoptedStyleSheets.indexOf(this.sheet)<0&&(t.adoptedStyleSheets=[this.sheet,...t.adoptedStyleSheets]);else{let e="";for(let t=0;t<this.modules.length;t++)e+=this.modules[t].getRules()+"\n";this.styleTag.textContent=e;let s=t.head||t;this.styleTag.parentNode!=s&&s.insertBefore(this.styleTag,s.firstChild)}}setNonce(e){this.styleTag&&this.styleTag.getAttribute("nonce")!=e&&this.styleTag.setAttribute("nonce",e)}}export{StyleModule};

