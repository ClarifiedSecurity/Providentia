// @fortawesome/fontawesome-svg-core@7.3.0 downloaded from https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@7.3.0/index.mjs

/*!
* Font Awesome Free 7.3.0 by @fontawesome - https://fontawesome.com
* License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License)
* Copyright 2026 Fonticons, Inc.
*/
function e(e,t){(t==null||t>e.length)&&(t=e.length);for(var n=0,r=Array(t);n<t;n++)r[n]=e[n];return r}function t(e){if(Array.isArray(e))return e}function n(t){if(Array.isArray(t))return e(t)}function r(e,t){if(!(e instanceof t))throw TypeError(`Cannot call a class as a function`)}function i(e,t){for(var n=0;n<t.length;n++){var r=t[n];r.enumerable=r.enumerable||!1,r.configurable=!0,`value`in r&&(r.writable=!0),Object.defineProperty(e,y(r.key),r)}}function a(e,t,n){return t&&i(e.prototype,t),n&&i(e,n),Object.defineProperty(e,"prototype",{writable:!1}),e}function o(e,t){var n=typeof Symbol<`u`&&e[Symbol.iterator]||e[`@@iterator`];if(!n){if(Array.isArray(e)||(n=x(e))||t&&e&&typeof e.length==`number`){n&&(e=n);var r=0,i=function(){};return{s:i,n:function(){return r>=e.length?{done:!0}:{done:!1,value:e[r++]}},e:function(e){throw e},f:i}}throw TypeError(`Invalid attempt to iterate non-iterable instance.
In order to be iterable, non-array objects must have a [Symbol.iterator]() method.`)}var a,o=!0,s=!1;return{s:function(){n=n.call(e)},n:function(){var e=n.next();return o=e.done,e},e:function(e){s=!0,a=e},f:function(){try{o||n.return==null||n.return()}finally{if(s)throw a}}}}function s(e,t,n){return(t=y(t))in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function c(e,t){if(typeof t!=`function`&&t!==null)throw TypeError(`Super expression must either be null or a function`);e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,writable:!0,configurable:!0}}),Object.defineProperty(e,"prototype",{writable:!1}),t&&h(e,t)}function l(e){if(typeof Symbol<`u`&&e[Symbol.iterator]!=null||e[`@@iterator`]!=null)return Array.from(e)}function u(e,t){var n=e==null?null:typeof Symbol<`u`&&e[Symbol.iterator]||e[`@@iterator`];if(n!=null){var r,i,a,o,s=[],c=!0,l=!1;try{if(a=(n=n.call(e)).next,t===0){if(Object(n)!==n)return;c=!1}else for(;!(c=(r=a.call(n)).done)&&(s.push(r.value),s.length!==t);c=!0);}catch(e){l=!0,i=e}finally{try{if(!c&&n.return!=null&&(o=n.return(),Object(o)!==o))return}finally{if(l)throw i}}return s}}function d(){throw TypeError(`Invalid attempt to destructure non-iterable instance.
In order to be iterable, non-array objects must have a [Symbol.iterator]() method.`)}function f(){throw TypeError(`Invalid attempt to spread non-iterable instance.
In order to be iterable, non-array objects must have a [Symbol.iterator]() method.`)}function p(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter(function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable})),n.push.apply(n,r)}return n}function m(e){for(var t=1;t<arguments.length;t++){var n=arguments[t]==null?{}:arguments[t];t%2?p(Object(n),!0).forEach(function(t){s(e,t,n[t])}):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):p(Object(n)).forEach(function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))})}return e}function h(e,t){return h=Object.setPrototypeOf?Object.setPrototypeOf.bind():function(e,t){return e.__proto__=t,e},h(e,t)}function g(e,n){return t(e)||u(e,n)||x(e,n)||d()}function _(e){return n(e)||l(e)||x(e)||f()}function v(e,t){if(typeof e!=`object`||!e)return e;var n=e[Symbol.toPrimitive];if(n!==void 0){var r=n.call(e,t||`default`);if(typeof r!=`object`)return r;throw TypeError(`@@toPrimitive must return a primitive value.`)}return(t===`string`?String:Number)(e)}function y(e){var t=v(e,`string`);return typeof t==`symbol`?t:t+``}function b(e){"@babel/helpers - typeof";return b=typeof Symbol==`function`&&typeof Symbol.iterator==`symbol`?function(e){return typeof e}:function(e){return e&&typeof Symbol==`function`&&e.constructor===Symbol&&e!==Symbol.prototype?`symbol`:typeof e},b(e)}function x(t,n){if(t){if(typeof t==`string`)return e(t,n);var r={}.toString.call(t).slice(8,-1);return r===`Object`&&t.constructor&&(r=t.constructor.name),r===`Map`||r===`Set`?Array.from(t):r===`Arguments`||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(r)?e(t,n):void 0}}function S(){S=function(e,t){return new n(e,void 0,t)};var e=RegExp.prototype,t=/* @__PURE__ */ new WeakMap;function n(e,r,i){var a=RegExp(e,r);return t.set(a,i||t.get(e)),h(a,n.prototype)}function r(e,n){var r=t.get(n);return Object.keys(r).reduce(function(t,n){var i=r[n];if(typeof i==`number`)t[n]=e[i];else{for(var a=0;e[i[a]]===void 0&&a+1<i.length;)a++;t[n]=e[i[a]]}return t},Object.create(null))}return c(n,RegExp),n.prototype.exec=function(t){var n=e.exec.call(this,t);if(n){n.groups=r(n,this);var i=n.indices;i&&(i.groups=r(i,this))}return n},n.prototype[Symbol.replace]=function(n,i){if(typeof i==`string`){var a=t.get(this);return e[Symbol.replace].call(this,n,i.replace(/\$<([^>]+)(>|$)/g,function(e,t,n){if(n===``)return e;var r=a[t];return Array.isArray(r)?`$`+r.join(`$`):typeof r==`number`?`$`+r:``}))}if(typeof i==`function`){var o=this;return e[Symbol.replace].call(this,n,function(){var e=arguments;return typeof e[e.length-1]!=`object`&&(e=[].slice.call(e)).push(r(e,o)),i.apply(this,e)})}return e[Symbol.replace].call(this,n,i)},S.apply(this,arguments)}var ee=function e(){},te={},ne={},re=null,ie={mark:ee,measure:ee};try{typeof window<`u`&&(te=window),typeof document<`u`&&(ne=document),typeof MutationObserver<`u`&&(re=MutationObserver),typeof performance<`u`&&(ie=performance)}catch(e){}var ae=(te.navigator||{}).userAgent,oe=ae===void 0?``:ae,C=te,w=ne,se=re,ce=ie,le=!!C.document,T=!!w.documentElement&&!!w.head&&typeof w.addEventListener==`function`&&typeof w.createElement==`function`,ue=~oe.indexOf(`MSIE`)||~oe.indexOf(`Trident/`),de,fe=/fa(k|kd|s|r|l|t|d|dr|dl|dt|b|slr|slpr|wsb|tl|ns|nds|es|gt|jr|jfr|jdr|usb|ufsb|udsb|cr|ss|sr|sl|st|sds|sdr|sdl|sdt|sldr|slpdr|pr|ms|vs)?[\-\ ]/,pe=/Font ?Awesome ?([567 ]*)(Solid|Regular|Light|Thin|Duotone|Brands|Free|Pro|Sharp Duotone|Sharp|Kit|Notdog Duo|Notdog|Chisel|Etch|Graphite|Thumbprint|Jelly Fill|Jelly Duo|Jelly|Utility|Utility Fill|Utility Duo|Slab Press|Slab|Slab Duo|Slab Press Duo|Pixel|Mosaic|Vellum|Whiteboard)?.*/i,me={classic:{fa:`solid`,fas:`solid`,"fa-solid":`solid`,far:`regular`,"fa-regular":`regular`,fal:`light`,"fa-light":`light`,fat:`thin`,"fa-thin":`thin`,fab:`brands`,"fa-brands":`brands`},duotone:{fa:`solid`,fad:`solid`,"fa-solid":`solid`,"fa-duotone":`solid`,fadr:`regular`,"fa-regular":`regular`,fadl:`light`,"fa-light":`light`,fadt:`thin`,"fa-thin":`thin`},sharp:{fa:`solid`,fass:`solid`,"fa-solid":`solid`,fasr:`regular`,"fa-regular":`regular`,fasl:`light`,"fa-light":`light`,fast:`thin`,"fa-thin":`thin`},"sharp-duotone":{fa:`solid`,fasds:`solid`,"fa-solid":`solid`,fasdr:`regular`,"fa-regular":`regular`,fasdl:`light`,"fa-light":`light`,fasdt:`thin`,"fa-thin":`thin`},slab:{"fa-regular":`regular`,faslr:`regular`},"slab-press":{"fa-regular":`regular`,faslpr:`regular`},"slab-duo":{"fa-regular":`regular`,fasldr:`regular`},"slab-press-duo":{"fa-regular":`regular`,faslpdr:`regular`},thumbprint:{"fa-light":`light`,fatl:`light`},vellum:{"fa-solid":`solid`,favs:`solid`},pixel:{"fa-regular":`regular`,fapr:`regular`},mosaic:{"fa-solid":`solid`,fams:`solid`},whiteboard:{"fa-semibold":`semibold`,fawsb:`semibold`},notdog:{"fa-solid":`solid`,fans:`solid`},"notdog-duo":{"fa-solid":`solid`,fands:`solid`},etch:{"fa-solid":`solid`,faes:`solid`},graphite:{"fa-thin":`thin`,fagt:`thin`},jelly:{"fa-regular":`regular`,fajr:`regular`},"jelly-fill":{"fa-regular":`regular`,fajfr:`regular`},"jelly-duo":{"fa-regular":`regular`,fajdr:`regular`},chisel:{"fa-regular":`regular`,facr:`regular`},utility:{"fa-semibold":`semibold`,fausb:`semibold`},"utility-duo":{"fa-semibold":`semibold`,faudsb:`semibold`},"utility-fill":{"fa-semibold":`semibold`,faufsb:`semibold`}},he={GROUP:`duotone-group`,SWAP_OPACITY:`swap-opacity`,PRIMARY:`primary`,SECONDARY:`secondary`},ge=[`fa-classic`,`fa-duotone`,`fa-sharp`,`fa-sharp-duotone`,`fa-thumbprint`,`fa-whiteboard`,`fa-notdog`,`fa-notdog-duo`,`fa-chisel`,`fa-etch`,`fa-graphite`,`fa-jelly`,`fa-jelly-fill`,`fa-jelly-duo`,`fa-slab`,`fa-slab-press`,`fa-slab-press-duo`,`fa-slab-duo`,`fa-mosaic`,`fa-pixel`,`fa-vellum`,`fa-utility`,`fa-utility-duo`,`fa-utility-fill`],E=`classic`,D=`duotone`,_e=`sharp`,ve=`sharp-duotone`,ye=`chisel`,be=`etch`,xe=`graphite`,Se=`jelly`,Ce=`jelly-duo`,we=`jelly-fill`,Te=`mosaic`,Ee=`notdog`,De=`notdog-duo`,Oe=`pixel`,ke=`slab`,Ae=`slab-duo`,je=`slab-press`,Me=`slab-press-duo`,Ne=`thumbprint`,Pe=`utility`,Fe=`utility-duo`,Ie=`utility-fill`,Le=`vellum`,Re=`whiteboard`,ze=`Classic`,Be=`Duotone`,Ve=`Sharp`,He=`Sharp Duotone`,Ue=`Chisel`,We=`Etch`,Ge=`Graphite`,Ke=`Jelly`,qe=`Jelly Duo`,Je=`Jelly Fill`,Ye=`Mosaic`,Xe=`Notdog`,Ze=`Notdog Duo`,Qe=`Pixel`,$e=`Slab`,et=`Slab Duo`,tt=`Slab Press`,nt=`Slab Press Duo`,rt=`Thumbprint`,it=`Utility`,at=`Utility Duo`,ot=`Utility Fill`,st=`Vellum`,ct=`Whiteboard`,lt=[E,D,_e,ve,ye,be,xe,Se,Ce,we,Te,Ee,De,Oe,ke,Ae,je,Me,Ne,Pe,Fe,Ie,Le,Re],ut=(de={},s(s(s(s(s(s(s(s(s(s(de,E,ze),D,Be),_e,Ve),ve,He),ye,Ue),be,We),xe,Ge),Se,Ke),Ce,qe),we,Je),s(s(s(s(s(s(s(s(s(s(de,Te,Ye),Ee,Xe),De,Ze),Oe,Qe),ke,$e),Ae,et),je,tt),Me,nt),Ne,rt),Pe,it),s(s(s(s(de,Fe,at),Ie,ot),Le,st),Re,ct)),dt={classic:{900:`fas`,400:`far`,normal:`far`,300:`fal`,100:`fat`},duotone:{900:`fad`,400:`fadr`,300:`fadl`,100:`fadt`},sharp:{900:`fass`,400:`fasr`,300:`fasl`,100:`fast`},"sharp-duotone":{900:`fasds`,400:`fasdr`,300:`fasdl`,100:`fasdt`},slab:{400:`faslr`},"slab-press":{400:`faslpr`},"slab-duo":{400:`fasldr`},"slab-press-duo":{400:`faslpdr`},vellum:{900:`favs`},mosaic:{900:`fams`},pixel:{400:`fapr`},whiteboard:{600:`fawsb`},thumbprint:{300:`fatl`},notdog:{900:`fans`},"notdog-duo":{900:`fands`},etch:{900:`faes`},graphite:{100:`fagt`},chisel:{400:`facr`},jelly:{400:`fajr`},"jelly-fill":{400:`fajfr`},"jelly-duo":{400:`fajdr`},utility:{600:`fausb`},"utility-duo":{600:`faudsb`},"utility-fill":{600:`faufsb`}},ft={"Font Awesome 7 Free":{900:`fas`,400:`far`},"Font Awesome 7 Pro":{900:`fas`,400:`far`,normal:`far`,300:`fal`,100:`fat`},"Font Awesome 7 Brands":{400:`fab`,normal:`fab`},"Font Awesome 7 Duotone":{900:`fad`,400:`fadr`,normal:`fadr`,300:`fadl`,100:`fadt`},"Font Awesome 7 Sharp":{900:`fass`,400:`fasr`,normal:`fasr`,300:`fasl`,100:`fast`},"Font Awesome 7 Sharp Duotone":{900:`fasds`,400:`fasdr`,normal:`fasdr`,300:`fasdl`,100:`fasdt`},"Font Awesome 7 Jelly":{400:`fajr`,normal:`fajr`},"Font Awesome 7 Jelly Fill":{400:`fajfr`,normal:`fajfr`},"Font Awesome 7 Jelly Duo":{400:`fajdr`,normal:`fajdr`},"Font Awesome 7 Slab":{400:`faslr`,normal:`faslr`},"Font Awesome 7 Slab Press":{400:`faslpr`,normal:`faslpr`},"Font Awesome 7 Slab Duo":{400:`fasldr`,normal:`fasldr`},"Font Awesome 7 Slab Press Duo":{400:`faslpdr`,normal:`faslpdr`},"Font Awesome 7 Pixel":{400:`fapr`,normal:`fapr`},"Font Awesome 7 Mosaic":{900:`fams`,normal:`fams`},"Font Awesome 7 Vellum":{900:`favs`,normal:`favs`},"Font Awesome 7 Thumbprint":{300:`fatl`,normal:`fatl`},"Font Awesome 7 Notdog":{900:`fans`,normal:`fans`},"Font Awesome 7 Notdog Duo":{900:`fands`,normal:`fands`},"Font Awesome 7 Etch":{900:`faes`,normal:`faes`},"Font Awesome 7 Graphite":{100:`fagt`,normal:`fagt`},"Font Awesome 7 Chisel":{400:`facr`,normal:`facr`},"Font Awesome 7 Whiteboard":{600:`fawsb`,normal:`fawsb`},"Font Awesome 7 Utility":{600:`fausb`,normal:`fausb`},"Font Awesome 7 Utility Duo":{600:`faudsb`,normal:`faudsb`},"Font Awesome 7 Utility Fill":{600:`faufsb`,normal:`faufsb`}},pt=new Map([[`classic`,{defaultShortPrefixId:`fas`,defaultStyleId:`solid`,styleIds:[`solid`,`regular`,`light`,`thin`,`brands`],futureStyleIds:[],defaultFontWeight:900}],[`duotone`,{defaultShortPrefixId:`fad`,defaultStyleId:`solid`,styleIds:[`solid`,`regular`,`light`,`thin`],futureStyleIds:[],defaultFontWeight:900}],[`sharp`,{defaultShortPrefixId:`fass`,defaultStyleId:`solid`,styleIds:[`solid`,`regular`,`light`,`thin`],futureStyleIds:[],defaultFontWeight:900}],[`sharp-duotone`,{defaultShortPrefixId:`fasds`,defaultStyleId:`solid`,styleIds:[`solid`,`regular`,`light`,`thin`],futureStyleIds:[],defaultFontWeight:900}],[`chisel`,{defaultShortPrefixId:`facr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`etch`,{defaultShortPrefixId:`faes`,defaultStyleId:`solid`,styleIds:[`solid`],futureStyleIds:[],defaultFontWeight:900}],[`graphite`,{defaultShortPrefixId:`fagt`,defaultStyleId:`thin`,styleIds:[`thin`],futureStyleIds:[],defaultFontWeight:100}],[`jelly`,{defaultShortPrefixId:`fajr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`jelly-duo`,{defaultShortPrefixId:`fajdr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`jelly-fill`,{defaultShortPrefixId:`fajfr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`mosaic`,{defaultShortPrefixId:`fams`,defaultStyleId:`solid`,styleIds:[`solid`],futureStyleIds:[],defaultFontWeight:900}],[`notdog`,{defaultShortPrefixId:`fans`,defaultStyleId:`solid`,styleIds:[`solid`],futureStyleIds:[],defaultFontWeight:900}],[`notdog-duo`,{defaultShortPrefixId:`fands`,defaultStyleId:`solid`,styleIds:[`solid`],futureStyleIds:[],defaultFontWeight:900}],[`pixel`,{defaultShortPrefixId:`fapr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`slab`,{defaultShortPrefixId:`faslr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`slab-duo`,{defaultShortPrefixId:`fasldr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`slab-press`,{defaultShortPrefixId:`faslpr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`slab-press-duo`,{defaultShortPrefixId:`faslpdr`,defaultStyleId:`regular`,styleIds:[`regular`],futureStyleIds:[],defaultFontWeight:400}],[`thumbprint`,{defaultShortPrefixId:`fatl`,defaultStyleId:`light`,styleIds:[`light`],futureStyleIds:[],defaultFontWeight:300}],[`utility`,{defaultShortPrefixId:`fausb`,defaultStyleId:`semibold`,styleIds:[`semibold`],futureStyleIds:[],defaultFontWeight:600}],[`utility-duo`,{defaultShortPrefixId:`faudsb`,defaultStyleId:`semibold`,styleIds:[`semibold`],futureStyleIds:[],defaultFontWeight:600}],[`utility-fill`,{defaultShortPrefixId:`faufsb`,defaultStyleId:`semibold`,styleIds:[`semibold`],futureStyleIds:[],defaultFontWeight:600}],[`vellum`,{defaultShortPrefixId:`favs`,defaultStyleId:`solid`,styleIds:[`solid`],futureStyleIds:[],defaultFontWeight:900}],[`whiteboard`,{defaultShortPrefixId:`fawsb`,defaultStyleId:`semibold`,styleIds:[`semibold`],futureStyleIds:[],defaultFontWeight:600}]]),mt={chisel:{regular:`facr`},classic:{brands:`fab`,light:`fal`,regular:`far`,solid:`fas`,thin:`fat`},duotone:{light:`fadl`,regular:`fadr`,solid:`fad`,thin:`fadt`},etch:{solid:`faes`},graphite:{thin:`fagt`},jelly:{regular:`fajr`},"jelly-duo":{regular:`fajdr`},"jelly-fill":{regular:`fajfr`},mosaic:{solid:`fams`},notdog:{solid:`fans`},"notdog-duo":{solid:`fands`},pixel:{regular:`fapr`},sharp:{light:`fasl`,regular:`fasr`,solid:`fass`,thin:`fast`},"sharp-duotone":{light:`fasdl`,regular:`fasdr`,solid:`fasds`,thin:`fasdt`},slab:{regular:`faslr`},"slab-duo":{regular:`fasldr`},"slab-press":{regular:`faslpr`},"slab-press-duo":{regular:`faslpdr`},thumbprint:{light:`fatl`},utility:{semibold:`fausb`},"utility-duo":{semibold:`faudsb`},"utility-fill":{semibold:`faufsb`},vellum:{solid:`favs`},whiteboard:{semibold:`fawsb`}},ht=[`fak`,`fa-kit`,`fakd`,`fa-kit-duotone`],gt={kit:{fak:`kit`,"fa-kit":`kit`},"kit-duotone":{fakd:`kit-duotone`,"fa-kit-duotone":`kit-duotone`}},_t=[`kit`],vt=s(s({},`kit`,`Kit`),`kit-duotone`,`Kit Duotone`),yt={kit:{"fa-kit":`fak`},"kit-duotone":{"fa-kit-duotone":`fakd`}},bt={"Font Awesome Kit":{400:`fak`,normal:`fak`},"Font Awesome Kit Duotone":{400:`fakd`,normal:`fakd`}},xt={kit:{fak:`fa-kit`},"kit-duotone":{fakd:`fa-kit-duotone`}},St={kit:{kit:`fak`},"kit-duotone":{"kit-duotone":`fakd`}},O,k={GROUP:`duotone-group`,SWAP_OPACITY:`swap-opacity`,PRIMARY:`primary`,SECONDARY:`secondary`},Ct=[`fa-classic`,`fa-duotone`,`fa-sharp`,`fa-sharp-duotone`,`fa-thumbprint`,`fa-whiteboard`,`fa-notdog`,`fa-notdog-duo`,`fa-chisel`,`fa-etch`,`fa-graphite`,`fa-jelly`,`fa-jelly-fill`,`fa-jelly-duo`,`fa-slab`,`fa-slab-press`,`fa-slab-press-duo`,`fa-slab-duo`,`fa-mosaic`,`fa-pixel`,`fa-vellum`,`fa-utility`,`fa-utility-duo`,`fa-utility-fill`],wt=(O={},s(s(s(s(s(s(s(s(s(s(O,`classic`,`Classic`),`duotone`,`Duotone`),`sharp`,`Sharp`),`sharp-duotone`,`Sharp Duotone`),`chisel`,`Chisel`),`etch`,`Etch`),`graphite`,`Graphite`),`jelly`,`Jelly`),`jelly-duo`,`Jelly Duo`),`jelly-fill`,`Jelly Fill`),s(s(s(s(s(s(s(s(s(s(O,`mosaic`,`Mosaic`),`notdog`,`Notdog`),`notdog-duo`,`Notdog Duo`),`pixel`,`Pixel`),`slab`,`Slab`),`slab-duo`,`Slab Duo`),`slab-press`,`Slab Press`),`slab-press-duo`,`Slab Press Duo`),`thumbprint`,`Thumbprint`),`utility`,`Utility`),s(s(s(s(O,`utility-duo`,`Utility Duo`),`utility-fill`,`Utility Fill`),`vellum`,`Vellum`),`whiteboard`,`Whiteboard`)),Tt=s(s({},`kit`,`Kit`),`kit-duotone`,`Kit Duotone`),Et={classic:{"fa-brands":`fab`,"fa-duotone":`fad`,"fa-light":`fal`,"fa-regular":`far`,"fa-solid":`fas`,"fa-thin":`fat`},duotone:{"fa-regular":`fadr`,"fa-light":`fadl`,"fa-thin":`fadt`},sharp:{"fa-solid":`fass`,"fa-regular":`fasr`,"fa-light":`fasl`,"fa-thin":`fast`},"sharp-duotone":{"fa-solid":`fasds`,"fa-regular":`fasdr`,"fa-light":`fasdl`,"fa-thin":`fasdt`},slab:{"fa-regular":`faslr`},"slab-press":{"fa-regular":`faslpr`},"slab-duo":{"fa-regular":`fasldr`},"slab-press-duo":{"fa-regular":`faslpdr`},pixel:{"fa-regular":`fapr`},mosaic:{"fa-solid":`fams`},vellum:{"fa-solid":`favs`},whiteboard:{"fa-semibold":`fawsb`},thumbprint:{"fa-light":`fatl`},notdog:{"fa-solid":`fans`},"notdog-duo":{"fa-solid":`fands`},etch:{"fa-solid":`faes`},graphite:{"fa-thin":`fagt`},jelly:{"fa-regular":`fajr`},"jelly-fill":{"fa-regular":`fajfr`},"jelly-duo":{"fa-regular":`fajdr`},chisel:{"fa-regular":`facr`},utility:{"fa-semibold":`fausb`},"utility-duo":{"fa-semibold":`faudsb`},"utility-fill":{"fa-semibold":`faufsb`}},Dt={classic:[`fas`,`far`,`fal`,`fat`,`fad`],duotone:[`fadr`,`fadl`,`fadt`],sharp:[`fass`,`fasr`,`fasl`,`fast`],"sharp-duotone":[`fasds`,`fasdr`,`fasdl`,`fasdt`],slab:[`faslr`],"slab-press":[`faslpr`],"slab-duo":[`fasldr`],"slab-press-duo":[`faslpdr`],pixel:[`fapr`],mosaic:[`fams`],vellum:[`favs`],whiteboard:[`fawsb`],thumbprint:[`fatl`],notdog:[`fans`],"notdog-duo":[`fands`],etch:[`faes`],graphite:[`fagt`],jelly:[`fajr`],"jelly-fill":[`fajfr`],"jelly-duo":[`fajdr`],chisel:[`facr`],utility:[`fausb`],"utility-duo":[`faudsb`],"utility-fill":[`faufsb`]},Ot={classic:{fab:`fa-brands`,fad:`fa-duotone`,fal:`fa-light`,far:`fa-regular`,fas:`fa-solid`,fat:`fa-thin`},duotone:{fadr:`fa-regular`,fadl:`fa-light`,fadt:`fa-thin`},sharp:{fass:`fa-solid`,fasr:`fa-regular`,fasl:`fa-light`,fast:`fa-thin`},"sharp-duotone":{fasds:`fa-solid`,fasdr:`fa-regular`,fasdl:`fa-light`,fasdt:`fa-thin`},slab:{faslr:`fa-regular`},"slab-press":{faslpr:`fa-regular`},"slab-duo":{fasldr:`fa-regular`},"slab-press-duo":{faslpdr:`fa-regular`},pixel:{fapr:`fa-regular`},mosaic:{fams:`fa-solid`},vellum:{favs:`fa-solid`},whiteboard:{fawsb:`fa-semibold`},thumbprint:{fatl:`fa-light`},notdog:{fans:`fa-solid`},"notdog-duo":{fands:`fa-solid`},etch:{faes:`fa-solid`},graphite:{fagt:`fa-thin`},jelly:{fajr:`fa-regular`},"jelly-fill":{fajfr:`fa-regular`},"jelly-duo":{fajdr:`fa-regular`},chisel:{facr:`fa-regular`},utility:{fausb:`fa-semibold`},"utility-duo":{faudsb:`fa-semibold`},"utility-fill":{faufsb:`fa-semibold`}},kt=(/* @__PURE__ */ `fa.fas.far.fal.fat.fad.fadr.fadl.fadt.fab.fass.fasr.fasl.fast.fasds.fasdr.fasdl.fasdt.faslr.faslpr.fasldr.faslpdr.fapr.fams.favs.fawsb.fatl.fans.fands.faes.fagt.fajr.fajfr.fajdr.facr.fausb.faudsb.faufsb`.split(`.`)).concat(Ct,[`fa-solid`,`fa-regular`,`fa-light`,`fa-thin`,`fa-duotone`,`fa-brands`,`fa-semibold`]),At=[`solid`,`regular`,`light`,`thin`,`duotone`,`brands`,`semibold`],jt=[1,2,3,4,5,6,7,8,9,10],Mt=jt.concat([11,12,13,14,15,16,17,18,19,20]),Nt=[].concat(_(Object.keys(Dt)),At,[`aw`,`fw`,`pull-left`,`pull-right`],[`2xs`,`xs`,`sm`,`lg`,`xl`,`2xl`,`beat`,`beat-fade`,`border`,`bounce`,`buzz`,`canvas-square`,`canvas-roomy`,`fade`,`flip-360`,`flip-both`,`flip-horizontal`,`flip-vertical`,`flip`,`float`,`inverse`,`jello`,`layers`,`layers-bottom-left`,`layers-bottom-right`,`layers-counter`,`layers-text`,`layers-top-left`,`layers-top-right`,`li`,`pull-end`,`pull-start`,`pulse`,`rotate-180`,`rotate-270`,`rotate-90`,`rotate-by`,`shake`,`spin-pulse`,`spin-reverse`,`spin`,`spin-snap`,`spin-snap-4`,`spin-snap-8`,`stack-1x`,`stack-2x`,`stack`,`swing`,`ul`,`wag`,`width-auto`,`width-fixed`,k.GROUP,k.SWAP_OPACITY,k.PRIMARY,k.SECONDARY],jt.map(function(e){return`${e}x`}),Mt.map(function(e){return`w-${e}`})),Pt={"Font Awesome 5 Free":{900:`fas`,400:`far`},"Font Awesome 5 Pro":{900:`fas`,400:`far`,normal:`far`,300:`fal`},"Font Awesome 5 Brands":{400:`fab`,normal:`fab`},"Font Awesome 5 Duotone":{900:`fad`}},A=`___FONT_AWESOME___`,Ft=16,It=`fa`,Lt=`svg-inline--fa`,j=`data-fa-i2svg`,Rt=`data-fa-pseudo-element`,zt=`data-fa-pseudo-element-pending`,Bt=`data-prefix`,Vt=`data-icon`,Ht=`fontawesome-i2svg`,Ut=`async`,Wt=[`HTML`,`HEAD`,`STYLE`,`SCRIPT`],Gt=[`::before`,`::after`,`:before`,`:after`],Kt=function(){try{return process.env.NODE_ENV===`production`}catch(e){return!1}}();function M(e){return new Proxy(e,{get:function e(t,n){return n in t?t[n]:t[E]}})}var qt=m({},me);qt[E]=m(m(m(m({},{"fa-duotone":`duotone`}),me[E]),gt.kit),gt[`kit-duotone`]);var Jt=M(qt),Yt=m({},mt);Yt[E]=m(m(m(m({},{duotone:`fad`}),Yt[E]),St.kit),St[`kit-duotone`]);var Xt=M(Yt),Zt=m({},Ot);Zt[E]=m(m({},Zt[E]),xt.kit);var Qt=M(Zt),$t=m({},Et);$t[E]=m(m({},$t[E]),yt.kit);var en=M($t),tn=fe,nn=`fa-layers-text`,rn=pe,an=M(m({},dt)),on=[`class`,`data-prefix`,`data-icon`,`data-fa-transform`,`data-fa-mask`],sn=he,cn=[].concat(_(_t),_(Nt)),N=C.FontAwesomeConfig||{};function ln(e){var t=w.querySelector(`script[`+e+`]`);if(t)return t.getAttribute(e)}function un(e){return e===``?!0:e===`false`?!1:e===`true`?!0:e}w&&typeof w.querySelector==`function`&&[[`data-family-prefix`,`familyPrefix`],[`data-css-prefix`,`cssPrefix`],[`data-family-default`,`familyDefault`],[`data-style-default`,`styleDefault`],[`data-replacement-class`,`replacementClass`],[`data-auto-replace-svg`,`autoReplaceSvg`],[`data-auto-add-css`,`autoAddCss`],[`data-search-pseudo-elements`,`searchPseudoElements`],[`data-search-pseudo-elements-warnings`,`searchPseudoElementsWarnings`],[`data-search-pseudo-elements-full-scan`,`searchPseudoElementsFullScan`],[`data-observe-mutations`,`observeMutations`],[`data-mutate-approach`,`mutateApproach`],[`data-keep-original-source`,`keepOriginalSource`],[`data-measure-performance`,`measurePerformance`],[`data-show-missing-icons`,`showMissingIcons`]].forEach(function(e){var t=g(e,2),n=t[0],r=t[1],i=un(ln(n));i!=null&&(N[r]=i)});var dn={styleDefault:`solid`,familyDefault:E,cssPrefix:It,replacementClass:Lt,autoReplaceSvg:!0,autoAddCss:!0,searchPseudoElements:!1,searchPseudoElementsWarnings:!0,searchPseudoElementsFullScan:!1,observeMutations:!0,mutateApproach:`async`,keepOriginalSource:!0,measurePerformance:!1,showMissingIcons:!0};N.familyPrefix&&(N.cssPrefix=N.familyPrefix);var P=m(m({},dn),N);P.autoReplaceSvg||(P.observeMutations=!1);var F={};Object.keys(dn).forEach(function(e){Object.defineProperty(F,e,{enumerable:!0,set:function t(n){P[e]=n,I.forEach(function(e){return e(F)})},get:function t(){return P[e]}})}),Object.defineProperty(F,"familyPrefix",{enumerable:!0,set:function e(t){P.cssPrefix=t,I.forEach(function(e){return e(F)})},get:function e(){return P.cssPrefix}}),C.FontAwesomeConfig=F;var I=[];function fn(e){return I.push(e),function(){I.splice(I.indexOf(e),1)}}var L=Ft,R={size:16,x:0,y:0,rotate:0,flipX:!1,flipY:!1};function pn(e){if(!(!e||!T)){var t=w.createElement(`style`);t.setAttribute(`type`,`text/css`),t.innerHTML=e;for(var n=w.head.childNodes,r=null,i=n.length-1;i>-1;i--){var a=n[i],o=(a.tagName||``).toUpperCase();[`STYLE`,`LINK`].indexOf(o)>-1&&(r=a)}return w.head.insertBefore(t,r),e}}var mn=`0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`;function hn(){for(var e=12,t=``;e-- >0;)t+=mn[Math.random()*62|0];return t}function z(e){for(var t=[],n=(e||[]).length>>>0;n--;)t[n]=e[n];return t}function gn(e){return e.classList?z(e.classList):(e.getAttribute(`class`)||``).split(` `).filter(function(e){return e})}function _n(e){return`${e}`.replace(/&/g,`&amp;`).replace(/"/g,`&quot;`).replace(/'/g,`&#39;`).replace(/</g,`&lt;`).replace(/>/g,`&gt;`)}function vn(e){return Object.keys(e||{}).reduce(function(t,n){return t+`${n}="${_n(e[n])}" `},``).trim()}function B(e){return Object.keys(e||{}).reduce(function(t,n){return t+`${n}: ${e[n].trim()};`},``)}function yn(e){return e.size!==R.size||e.x!==R.x||e.y!==R.y||e.rotate!==R.rotate||e.flipX||e.flipY}function bn(e){var t=e.transform,n=e.containerWidth,r=e.iconWidth;return{outer:{transform:`translate(${n/2} 256)`},inner:{transform:`${`translate(${t.x*32}, ${t.y*32}) `} ${`scale(${t.size/16*(t.flipX?-1:1)}, ${t.size/16*(t.flipY?-1:1)}) `} ${`rotate(${t.rotate} 0 0)`}`},path:{transform:`translate(${r/2*-1} -256)`}}}function xn(e){var t=e.transform,n=e.width,r=n===void 0?Ft:n,i=e.height,a=i===void 0?Ft:i,o=e.startCentered,s=o===void 0?!1:o,c=``;return s&&ue?c+=`translate(${t.x/L-r/2}em, ${t.y/L-a/2}em) `:s?c+=`translate(calc(-50% + ${t.x/L}em), calc(-50% + ${t.y/L}em)) `:c+=`translate(${t.x/L}em, ${t.y/L}em) `,c+=`scale(${t.size/L*(t.flipX?-1:1)}, ${t.size/L*(t.flipY?-1:1)}) `,c+=`rotate(${t.rotate}deg) `,c}var Sn=`:root, :host {
  --fa-font-solid: normal 900 1em/1 'Font Awesome 7 Free';
  --fa-font-regular: normal 400 1em/1 'Font Awesome 7 Free';
  --fa-font-light: normal 300 1em/1 'Font Awesome 7 Pro';
  --fa-font-thin: normal 100 1em/1 'Font Awesome 7 Pro';
  --fa-font-duotone: normal 900 1em/1 'Font Awesome 7 Duotone';
  --fa-font-duotone-regular: normal 400 1em/1 'Font Awesome 7 Duotone';
  --fa-font-duotone-light: normal 300 1em/1 'Font Awesome 7 Duotone';
  --fa-font-duotone-thin: normal 100 1em/1 'Font Awesome 7 Duotone';
  --fa-font-brands: normal 400 1em/1 'Font Awesome 7 Brands';
  --fa-font-sharp-solid: normal 900 1em/1 'Font Awesome 7 Sharp';
  --fa-font-sharp-regular: normal 400 1em/1 'Font Awesome 7 Sharp';
  --fa-font-sharp-light: normal 300 1em/1 'Font Awesome 7 Sharp';
  --fa-font-sharp-thin: normal 100 1em/1 'Font Awesome 7 Sharp';
  --fa-font-sharp-duotone-solid: normal 900 1em/1 'Font Awesome 7 Sharp Duotone';
  --fa-font-sharp-duotone-regular: normal 400 1em/1 'Font Awesome 7 Sharp Duotone';
  --fa-font-sharp-duotone-light: normal 300 1em/1 'Font Awesome 7 Sharp Duotone';
  --fa-font-sharp-duotone-thin: normal 100 1em/1 'Font Awesome 7 Sharp Duotone';
  --fa-font-slab-regular: normal 400 1em/1 'Font Awesome 7 Slab';
  --fa-font-slab-press-regular: normal 400 1em/1 'Font Awesome 7 Slab Press';
  --fa-font-slab-duo-regular: normal 400 1em/1 'Font Awesome 7 Slab Duo';
  --fa-font-slab-press-duo-regular: normal 400 1em/1 'Font Awesome 7 Slab Press Duo';
  --fa-font-pixel-regular: normal 400 1em/1 'Font Awesome 7 Pixel';
  --fa-font-mosaic-solid: normal 900 1em/1 'Font Awesome 7 Mosaic';
  --fa-font-vellum-solid: normal 900 1em/1 'Font Awesome 7 Vellum';
  --fa-font-whiteboard-semibold: normal 600 1em/1 'Font Awesome 7 Whiteboard';
  --fa-font-thumbprint-light: normal 300 1em/1 'Font Awesome 7 Thumbprint';
  --fa-font-notdog-solid: normal 900 1em/1 'Font Awesome 7 Notdog';
  --fa-font-notdog-duo-solid: normal 900 1em/1 'Font Awesome 7 Notdog Duo';
  --fa-font-etch-solid: normal 900 1em/1 'Font Awesome 7 Etch';
  --fa-font-graphite-thin: normal 100 1em/1 'Font Awesome 7 Graphite';
  --fa-font-jelly-regular: normal 400 1em/1 'Font Awesome 7 Jelly';
  --fa-font-jelly-fill-regular: normal 400 1em/1 'Font Awesome 7 Jelly Fill';
  --fa-font-jelly-duo-regular: normal 400 1em/1 'Font Awesome 7 Jelly Duo';
  --fa-font-chisel-regular: normal 400 1em/1 'Font Awesome 7 Chisel';
  --fa-font-utility-semibold: normal 600 1em/1 'Font Awesome 7 Utility';
  --fa-font-utility-duo-semibold: normal 600 1em/1 'Font Awesome 7 Utility Duo';
  --fa-font-utility-fill-semibold: normal 600 1em/1 'Font Awesome 7 Utility Fill';
}

.svg-inline--fa {
  box-sizing: content-box;
  display: var(--fa-display, inline-block);
  height: 1em;
  overflow: visible;
  vertical-align: -0.125em;
  width: var(--fa-width, 1.25em);
}
.svg-inline--fa.fa-2xs {
  vertical-align: 0.1em;
}
.svg-inline--fa.fa-xs {
  vertical-align: 0em;
}
.svg-inline--fa.fa-sm {
  vertical-align: -0.0714285714em;
}
.svg-inline--fa.fa-lg {
  vertical-align: -0.2em;
}
.svg-inline--fa.fa-xl {
  vertical-align: -0.25em;
}
.svg-inline--fa.fa-2xl {
  vertical-align: -0.3125em;
}
.svg-inline--fa.fa-pull-left,
.svg-inline--fa .fa-pull-start {
  float: inline-start;
  margin-inline-end: var(--fa-pull-margin, 0.3em);
}
.svg-inline--fa.fa-pull-right,
.svg-inline--fa .fa-pull-end {
  float: inline-end;
  margin-inline-start: var(--fa-pull-margin, 0.3em);
}
.svg-inline--fa.fa-li {
  width: var(--fa-li-width, 2em);
  inset-inline-start: calc(-1 * var(--fa-li-width, 2em));
  inset-block-start: 0.25em; /* syncing vertical alignment with Web Font rendering */
}

.fa-layers-counter, .fa-layers-text {
  display: inline-block;
  position: absolute;
  text-align: center;
}

.fa-layers {
  display: inline-block;
  height: 1em;
  position: relative;
  text-align: center;
  vertical-align: -0.125em;
  width: var(--fa-width, 1.25em);
}
.fa-layers .svg-inline--fa {
  inset: 0;
  margin: auto;
  position: absolute;
  transform-origin: center center;
}

.fa-layers-text {
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  transform-origin: center center;
}

.fa-layers-counter {
  background-color: var(--fa-counter-background-color, #ff253a);
  border-radius: var(--fa-counter-border-radius, 1em);
  box-sizing: border-box;
  color: var(--fa-inverse, #fff);
  line-height: var(--fa-counter-line-height, 1);
  max-width: var(--fa-counter-max-width, 5em);
  min-width: var(--fa-counter-min-width, 1.5em);
  overflow: hidden;
  padding: var(--fa-counter-padding, 0.25em 0.5em);
  right: var(--fa-right, 0);
  text-overflow: ellipsis;
  top: var(--fa-top, 0);
  transform: scale(var(--fa-counter-scale, 0.25));
  transform-origin: top right;
}

.fa-layers-bottom-right {
  bottom: var(--fa-bottom, 0);
  right: var(--fa-right, 0);
  top: auto;
  transform: scale(var(--fa-layers-scale, 0.25));
  transform-origin: bottom right;
}

.fa-layers-bottom-left {
  bottom: var(--fa-bottom, 0);
  left: var(--fa-left, 0);
  right: auto;
  top: auto;
  transform: scale(var(--fa-layers-scale, 0.25));
  transform-origin: bottom left;
}

.fa-layers-top-right {
  top: var(--fa-top, 0);
  right: var(--fa-right, 0);
  transform: scale(var(--fa-layers-scale, 0.25));
  transform-origin: top right;
}

.fa-layers-top-left {
  left: var(--fa-left, 0);
  right: auto;
  top: var(--fa-top, 0);
  transform: scale(var(--fa-layers-scale, 0.25));
  transform-origin: top left;
}

.fa-1x {
  font-size: 1em;
}

.fa-2x {
  font-size: 2em;
}

.fa-3x {
  font-size: 3em;
}

.fa-4x {
  font-size: 4em;
}

.fa-5x {
  font-size: 5em;
}

.fa-6x {
  font-size: 6em;
}

.fa-7x {
  font-size: 7em;
}

.fa-8x {
  font-size: 8em;
}

.fa-9x {
  font-size: 9em;
}

.fa-10x {
  font-size: 10em;
}

.fa-2xs {
  font-size: calc(10 / 16 * 1em); /* converts a 10px size into an em-based value that's relative to the scale's 16px base */
  line-height: calc(1 / 10 * 1em); /* sets the line-height of the icon back to that of it's parent */
  vertical-align: calc((6 / 10 - 0.375) * 1em); /* vertically centers the icon taking into account the surrounding text's descender */
}

.fa-xs {
  font-size: calc(12 / 16 * 1em); /* converts a 12px size into an em-based value that's relative to the scale's 16px base */
  line-height: calc(1 / 12 * 1em); /* sets the line-height of the icon back to that of it's parent */
  vertical-align: calc((6 / 12 - 0.375) * 1em); /* vertically centers the icon taking into account the surrounding text's descender */
}

.fa-sm {
  font-size: calc(14 / 16 * 1em); /* converts a 14px size into an em-based value that's relative to the scale's 16px base */
  line-height: calc(1 / 14 * 1em); /* sets the line-height of the icon back to that of it's parent */
  vertical-align: calc((6 / 14 - 0.375) * 1em); /* vertically centers the icon taking into account the surrounding text's descender */
}

.fa-lg {
  font-size: calc(20 / 16 * 1em); /* converts a 20px size into an em-based value that's relative to the scale's 16px base */
  line-height: calc(1 / 20 * 1em); /* sets the line-height of the icon back to that of it's parent */
  vertical-align: calc((6 / 20 - 0.375) * 1em); /* vertically centers the icon taking into account the surrounding text's descender */
}

.fa-xl {
  font-size: calc(24 / 16 * 1em); /* converts a 24px size into an em-based value that's relative to the scale's 16px base */
  line-height: calc(1 / 24 * 1em); /* sets the line-height of the icon back to that of it's parent */
  vertical-align: calc((6 / 24 - 0.375) * 1em); /* vertically centers the icon taking into account the surrounding text's descender */
}

.fa-2xl {
  font-size: calc(32 / 16 * 1em); /* converts a 32px size into an em-based value that's relative to the scale's 16px base */
  line-height: calc(1 / 32 * 1em); /* sets the line-height of the icon back to that of it's parent */
  vertical-align: calc((6 / 32 - 0.375) * 1em); /* vertically centers the icon taking into account the surrounding text's descender */
}

.fa-width-auto {
  --fa-width: auto;
}

.fa-fw,
.fa-width-fixed {
  --fa-width: 1.25em;
}

.fa-canvas-square {
  padding-block: 0.125em;
  margin-block-end: -0.125em;
}

.fa-canvas-roomy {
  padding-block: 0.25em;
  padding-inline: 0.125em;
  margin-block-end: -0.25em;
  box-sizing: content-box;
}

.fa-ul {
  list-style-type: none;
  margin-inline-start: var(--fa-li-margin, 2.5em);
  padding-inline-start: 0;
}
.fa-ul > li {
  position: relative;
}

.fa-li {
  inset-inline-start: calc(-1 * var(--fa-li-width, 2em));
  position: absolute;
  text-align: center;
  width: var(--fa-li-width, 2em);
  line-height: inherit;
}

/* Heads Up: Bordered Icons will not be supported in the future!
  - This feature will be deprecated in the next major release of Font Awesome (v8)!
  - You may continue to use it in this version *v7), but it will not be supported in Font Awesome v8.
*/
/* Notes:
* --@{v.$css-prefix}-border-width = 1/16 by default (to render as ~1px based on a 16px default font-size)
* --@{v.$css-prefix}-border-padding =
  ** 3/16 for vertical padding (to give ~2px of vertical whitespace around an icon considering it's vertical alignment)
  ** 4/16 for horizontal padding (to give ~4px of horizontal whitespace around an icon)
*/
.fa-border {
  border-color: var(--fa-border-color, #eee);
  border-radius: var(--fa-border-radius, 0.1em);
  border-style: var(--fa-border-style, solid);
  border-width: var(--fa-border-width, 0.0625em);
  box-sizing: var(--fa-border-box-sizing, content-box);
  padding: var(--fa-border-padding, 0.1875em 0.25em);
}

.fa-pull-left,
.fa-pull-start {
  float: inline-start;
  margin-inline-end: var(--fa-pull-margin, 0.3em);
}

.fa-pull-right,
.fa-pull-end {
  float: inline-end;
  margin-inline-start: var(--fa-pull-margin, 0.3em);
}

.fa-beat {
  animation-name: fa-beat;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 1s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-in-out);
}

.fa-bounce {
  animation-name: fa-bounce;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 1s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.28, 0.84, 0.42, 1));
}

.fa-fade {
  animation-name: fa-fade;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 1s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-in-out);
}

.fa-beat-fade {
  animation-name: fa-beat-fade;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 1s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-in-out);
}

.fa-flip {
  animation-name: fa-flip;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 1.5s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-in-out);
}

.fa-flip-360 {
  animation-name: fa-flip-360;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 1s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-in-out);
}

.fa-shake {
  animation-name: fa-shake;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 0.75s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-in-out);
}

.fa-spin {
  animation-name: fa-spin;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 2s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, linear);
}

.fa-spin-reverse {
  --fa-animation-direction: reverse;
}

.fa-pulse,
.fa-spin-pulse {
  animation-name: fa-spin;
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 1s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, steps(8));
}

.fa-spin-snap {
  animation-name: fa-spin-snap;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 3s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, linear);
}

.fa-spin-snap-4 {
  animation-name: fa-spin-snap-4;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 2.4s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, linear);
}

.fa-spin-snap-8 {
  animation-name: fa-spin-snap-8;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 4s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, linear);
}

.fa-buzz {
  animation-name: fa-buzz;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 0.6s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, linear);
}

.fa-wag {
  animation-name: fa-wag;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 0.9s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-out);
  transform-origin: bottom center;
}

.fa-float {
  animation-name: fa-float;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 3s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-in-out);
  will-change: transform;
}

.fa-swing {
  animation-name: fa-swing;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 1.2s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-out);
  transform-origin: top center;
}

.fa-jello {
  animation-name: fa-jello;
  animation-delay: var(--fa-animation-delay, 0s);
  animation-direction: var(--fa-animation-direction, normal);
  animation-duration: var(--fa-animation-duration, 0.9s);
  animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  animation-timing-function: var(--fa-animation-timing, ease-out);
}

@media (prefers-reduced-motion: reduce) {
  .fa-beat,
  .fa-bounce,
  .fa-fade,
  .fa-beat-fade,
  .fa-flip,
  .fa-flip-360,
  .fa-pulse,
  .fa-shake,
  .fa-spin,
  .fa-spin-pulse,
  .fa-buzz,
  .fa-float,
  .fa-jello,
  .fa-spin-snap,
  .fa-spin-snap-4,
  .fa-spin-snap-8,
  .fa-swing,
  .fa-wag {
    animation: none !important;
    transition: none !important;
  }
}
@keyframes fa-beat {
  0% {
    transform: scale(1);
  }
  25% {
    transform: scale(calc(1.25 * var(--fa-beat-scale, 1.25)));
  }
  45% {
    transform: scale(calc(1.22 * var(--fa-beat-scale, 1.22)));
  }
  65% {
    transform: scale(calc(1.25 * var(--fa-beat-scale, 1.25)));
  }
  90% {
    transform: scale(1);
  }
}
@keyframes fa-bounce {
  0% {
    transform: scale(1, 1) translateY(0);
    animation-timing-function: var(--fa-animation-timing);
  }
  14% {
    transform: scale(var(--fa-bounce-start-scale-x, 1.06), var(--fa-bounce-start-scale-y, 0.94)) translateY(var(--fa-bounce-anticipation, 3px));
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 0.33);
  }
  32% {
    transform: scale(var(--fa-bounce-jump-scale-x, 0.94), var(--fa-bounce-jump-scale-y, 1.12)) translateY(calc(-1 * var(--fa-bounce-height, 0.5em)));
    animation-timing-function: cubic-bezier(0.33, 0.66, 0.66, 1);
  }
  52% {
    transform: scale(1, 1) translateY(calc(-1 * var(--fa-bounce-height, 0.5em) * 1.1));
    animation-timing-function: cubic-bezier(0.5, 0, 1, 0.5);
  }
  70% {
    transform: scale(var(--fa-bounce-land-scale-x, 1.06), var(--fa-bounce-land-scale-y, 0.92)) translateY(0);
    animation-timing-function: cubic-bezier(0.33, 0.33, 0.66, 1);
  }
  85% {
    transform: scale(0.98, 1.04) translateY(calc(-2px * var(--fa-bounce-rebound, 1)));
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 1);
  }
  100% {
    transform: scale(1, 1) translateY(0);
  }
}
@keyframes fa-fade {
  0% {
    opacity: 1;
    transform: scale(1);
    animation-timing-function: cubic-bezier(0.2, 0, 0.4, 1);
  }
  40% {
    opacity: var(--fa-fade-opacity, 0.4);
    transform: scale(0.98);
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  100% {
    opacity: 1;
    transform: scale(1);
  }
}
@keyframes fa-beat-fade {
  0% {
    opacity: var(--fa-beat-fade-opacity, 0.4);
    transform: scale(1);
    animation-timing-function: cubic-bezier(0.2, 0, 0.4, 1);
  }
  25% {
    opacity: calc(var(--fa-beat-fade-opacity, 0.4) + 0.4);
    transform: scale(var(--fa-beat-fade-scale, 1.28));
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  45% {
    opacity: 1;
    transform: scale(var(--fa-beat-fade-scale, 1.25));
    animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  }
  65% {
    opacity: calc(var(--fa-beat-fade-opacity, 0.4) + 0.4);
    transform: scale(var(--fa-beat-fade-scale, 1.28));
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  100% {
    opacity: var(--fa-beat-fade-opacity, 0.4);
    transform: scale(1);
  }
}
@keyframes fa-flip {
  0% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), 0deg);
    animation-timing-function: cubic-bezier(0.2, 0, 0.4, 1);
  }
  8% {
    transform: perspective(2em) scale(var(--fa-flip-anticipation-scale, 0.95)) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), 0deg);
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 0.33);
  }
  35% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), calc(var(--fa-flip-angle, -360deg) * 0.6));
    animation-timing-function: linear;
  }
  65% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), calc(var(--fa-flip-angle, -360deg) * 0.5));
    animation-timing-function: cubic-bezier(0.33, 0.66, 0.66, 1);
  }
  92% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), calc(var(--fa-flip-angle, -360deg) * var(--fa-flip-overshoot, 1.04)));
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 1);
  }
  100% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), var(--fa-flip-angle, -360deg));
  }
}
@keyframes fa-flip-360 {
  0% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), 0deg);
    animation-timing-function: cubic-bezier(0.2, 0, 0.4, 1);
  }
  8% {
    transform: perspective(2em) scale(var(--fa-flip-anticipation-scale, 0.95)) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), 0deg);
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 0.33);
  }
  50% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), calc(var(--fa-flip-angle, -360deg) * 0.6));
    animation-timing-function: cubic-bezier(0.33, 0.66, 0.66, 1);
  }
  80% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), calc(var(--fa-flip-angle, -360deg) * var(--fa-flip-overshoot, 1.04)));
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 1);
  }
  100% {
    transform: perspective(2em) scale(1) rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), var(--fa-flip-angle, -360deg));
  }
}
@keyframes fa-shake {
  0% {
    transform: rotate(0deg);
    animation-timing-function: cubic-bezier(0.2, 0, 0.8, 1);
  }
  8% {
    transform: rotate(35deg) translateX(1px);
    animation-timing-function: cubic-bezier(0.3, 0, 0.7, 1);
  }
  20% {
    transform: rotate(-22deg) translateX(-1px);
    animation-timing-function: cubic-bezier(0.3, 0, 0.7, 1);
  }
  35% {
    transform: rotate(15deg) translateX(1px);
    animation-timing-function: cubic-bezier(0.3, 0, 0.7, 1);
  }
  50% {
    transform: rotate(-9deg);
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  65% {
    transform: rotate(5deg);
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  78% {
    transform: rotate(-3deg);
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  90% {
    transform: rotate(1deg);
    animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  }
  100% {
    transform: rotate(0deg);
  }
}
@keyframes fa-spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
@keyframes fa-spin-snap {
  0% {
    transform: rotate(0deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  12% {
    transform: rotate(60deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  16.67% {
    transform: rotate(60deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  28.67% {
    transform: rotate(120deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  33.33% {
    transform: rotate(120deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  45.33% {
    transform: rotate(180deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  50% {
    transform: rotate(180deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  62% {
    transform: rotate(240deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  66.67% {
    transform: rotate(240deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  78.67% {
    transform: rotate(300deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  83.33% {
    transform: rotate(300deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  95.33% {
    transform: rotate(360deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  100% {
    transform: rotate(360deg);
  }
}
@keyframes fa-spin-snap-4 {
  0% {
    transform: rotate(0deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  15% {
    transform: rotate(90deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  25% {
    transform: rotate(90deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  40% {
    transform: rotate(180deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  50% {
    transform: rotate(180deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  65% {
    transform: rotate(270deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  75% {
    transform: rotate(270deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  90% {
    transform: rotate(360deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  100% {
    transform: rotate(360deg);
  }
}
@keyframes fa-spin-snap-8 {
  0% {
    transform: rotate(0deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  9% {
    transform: rotate(45deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  12.5% {
    transform: rotate(45deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  21.5% {
    transform: rotate(90deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  25% {
    transform: rotate(90deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  34% {
    transform: rotate(135deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  37.5% {
    transform: rotate(135deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  46.5% {
    transform: rotate(180deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  50% {
    transform: rotate(180deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  59% {
    transform: rotate(225deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  62.5% {
    transform: rotate(225deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  71.5% {
    transform: rotate(270deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  75% {
    transform: rotate(270deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  84% {
    transform: rotate(315deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  87.5% {
    transform: rotate(315deg);
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
  }
  96.5% {
    transform: rotate(360deg);
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
  }
  100% {
    transform: rotate(360deg);
  }
}
@keyframes fa-buzz {
  0% {
    transform: translateX(0) rotate(0deg);
    animation-timing-function: cubic-bezier(0.1, 0, 0.9, 1);
  }
  5% {
    transform: translateX(var(--fa-buzz-distance, 4px)) rotate(0.5deg);
  }
  10% {
    transform: translateX(calc(-1 * var(--fa-buzz-distance, 4px))) rotate(-0.5deg);
  }
  15% {
    transform: translateX(var(--fa-buzz-distance, 4px)) rotate(0.3deg);
  }
  20% {
    transform: translateX(calc(-1 * var(--fa-buzz-distance, 4px))) rotate(-0.3deg);
  }
  25% {
    transform: translateX(calc(var(--fa-buzz-distance, 4px) * 0.7)) rotate(0.2deg);
  }
  30% {
    transform: translateX(calc(-1 * var(--fa-buzz-distance, 4px) * 0.7)) rotate(-0.2deg);
  }
  35% {
    transform: translateX(calc(var(--fa-buzz-distance, 4px) * 0.4)) rotate(0.1deg);
  }
  40% {
    transform: translateX(0) rotate(0deg);
  }
  100% {
    transform: translateX(0) rotate(0deg);
  }
}
@keyframes fa-wag {
  0% {
    transform: rotate(0deg);
    animation-timing-function: cubic-bezier(0.2, 0, 0.6, 1);
  }
  12% {
    transform: rotate(var(--fa-wag-angle, 12deg));
    animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  }
  24% {
    transform: rotate(2deg);
    animation-timing-function: cubic-bezier(0.2, 0, 0.6, 1);
  }
  36% {
    transform: rotate(calc(var(--fa-wag-angle, 12deg) * 0.85));
    animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  }
  48% {
    transform: rotate(1deg);
    animation-timing-function: cubic-bezier(0.2, 0, 0.6, 1);
  }
  58% {
    transform: rotate(calc(var(--fa-wag-angle, 12deg) * 0.6));
    animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  }
  68% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(0deg);
  }
}
@keyframes fa-float {
  0% {
    transform: translateY(0) translateX(0) rotate(0deg) scale(var(--fa-float-squash-x, 1.02), var(--fa-float-squash-y, 0.98));
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 0.33);
  }
  15% {
    transform: translateY(calc(-0.4 * var(--fa-float-height, 6px))) translateX(var(--fa-float-drift, 1px)) rotate(var(--fa-float-tilt, 1deg)) scale(1, 1);
    animation-timing-function: cubic-bezier(0.33, 0.66, 0.66, 1);
  }
  35% {
    transform: translateY(calc(-1 * var(--fa-float-height, 6px))) translateX(0) rotate(0deg) scale(var(--fa-float-stretch-x, 0.98), var(--fa-float-stretch-y, 1.03));
    animation-timing-function: cubic-bezier(0.5, 0, 0.5, 0);
  }
  50% {
    transform: translateY(calc(-0.92 * var(--fa-float-height, 6px))) translateX(calc(-0.5 * var(--fa-float-drift, 1px))) rotate(calc(-0.5 * var(--fa-float-tilt, 1deg))) scale(0.995, 1.01);
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 0.33);
  }
  70% {
    transform: translateY(calc(-0.3 * var(--fa-float-height, 6px))) translateX(calc(-1 * var(--fa-float-drift, 1px))) rotate(calc(-1 * var(--fa-float-tilt, 1deg))) scale(1, 1);
    animation-timing-function: cubic-bezier(0.33, 0.66, 0.66, 1);
  }
  90% {
    transform: translateY(calc(0.05 * var(--fa-float-height, 6px))) translateX(0) rotate(0deg) scale(var(--fa-float-squash-x, 1.02), var(--fa-float-squash-y, 0.98));
    animation-timing-function: cubic-bezier(0.33, 0, 0.66, 1);
  }
  100% {
    transform: translateY(0) translateX(0) rotate(0deg) scale(var(--fa-float-squash-x, 1.02), var(--fa-float-squash-y, 0.98));
  }
}
@keyframes fa-swing {
  0% {
    transform: rotate(0deg);
    animation-timing-function: cubic-bezier(0.2, 0, 0.8, 1);
  }
  8% {
    transform: rotate(var(--fa-swing-angle, 22deg));
    animation-timing-function: cubic-bezier(0.3, 0, 0.7, 1);
  }
  18% {
    transform: rotate(calc(-1 * var(--fa-swing-angle, 22deg) * 0.85));
    animation-timing-function: cubic-bezier(0.3, 0, 0.7, 1);
  }
  28% {
    transform: rotate(calc(var(--fa-swing-angle, 22deg) * 0.65));
    animation-timing-function: cubic-bezier(0.35, 0, 0.65, 1);
  }
  38% {
    transform: rotate(calc(-1 * var(--fa-swing-angle, 22deg) * 0.45));
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  48% {
    transform: rotate(calc(var(--fa-swing-angle, 22deg) * 0.25));
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  56% {
    transform: rotate(calc(-1 * var(--fa-swing-angle, 22deg) * 0.1));
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  64% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(0deg);
  }
}
@keyframes fa-jello {
  0% {
    transform: scale(1, 1);
    animation-timing-function: cubic-bezier(0.2, 0, 0.8, 1);
  }
  12% {
    transform: scale(var(--fa-jello-scale-x, 1.15), calc(2 - var(--fa-jello-scale-x, 1.15)));
    animation-timing-function: cubic-bezier(0.3, 0, 0.7, 1);
  }
  24% {
    transform: scale(calc(2 - var(--fa-jello-scale-y, 1.12)), var(--fa-jello-scale-y, 1.12));
    animation-timing-function: cubic-bezier(0.3, 0, 0.7, 1);
  }
  36% {
    transform: scale(calc(1 + (var(--fa-jello-scale-x, 1.15) - 1) * 0.5), calc(2 - (1 + (var(--fa-jello-scale-x, 1.15) - 1) * 0.5)));
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  48% {
    transform: scale(calc(2 - (1 + (var(--fa-jello-scale-y, 1.12) - 1) * 0.3)), calc(1 + (var(--fa-jello-scale-y, 1.12) - 1) * 0.3));
    animation-timing-function: cubic-bezier(0.4, 0, 0.6, 1);
  }
  58% {
    transform: scale(1.02, 0.98);
    animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  }
  68% {
    transform: scale(1, 1);
  }
  100% {
    transform: scale(1, 1);
  }
}
.fa-rotate-90 {
  transform: rotate(90deg);
}

.fa-rotate-180 {
  transform: rotate(180deg);
}

.fa-rotate-270 {
  transform: rotate(270deg);
}

.fa-flip-horizontal {
  transform: scale(-1, 1);
}

.fa-flip-vertical {
  transform: scale(1, -1);
}

.fa-flip-both,
.fa-flip-horizontal.fa-flip-vertical {
  transform: scale(-1, -1);
}

.fa-rotate-by {
  transform: rotate(var(--fa-rotate-angle, 0));
}

.svg-inline--fa .fa-primary {
  fill: var(--fa-primary-color, currentColor);
  opacity: var(--fa-primary-opacity, 1);
}

.svg-inline--fa .fa-secondary {
  fill: var(--fa-secondary-color, currentColor);
  opacity: var(--fa-secondary-opacity, 0.4);
}

.svg-inline--fa.fa-swap-opacity .fa-primary {
  opacity: var(--fa-secondary-opacity, 0.4);
}

.svg-inline--fa.fa-swap-opacity .fa-secondary {
  opacity: var(--fa-primary-opacity, 1);
}

.svg-inline--fa mask .fa-primary,
.svg-inline--fa mask .fa-secondary {
  fill: black;
}

.svg-inline--fa.fa-inverse {
  fill: var(--fa-inverse, #fff);
}

.fa-stack {
  display: inline-block;
  height: 2em;
  line-height: 2em;
  position: relative;
  vertical-align: middle;
  width: 2.5em;
}

.fa-inverse {
  color: var(--fa-inverse, #fff);
}

.svg-inline--fa.fa-stack-1x {
  --fa-width: 1.25em;
  height: 1em;
  width: var(--fa-width);
}
.svg-inline--fa.fa-stack-2x {
  --fa-width: 2.5em;
  height: 2em;
  width: var(--fa-width);
}

.fa-stack-1x,
.fa-stack-2x {
  inset: 0;
  margin: auto;
  position: absolute;
  z-index: var(--fa-stack-z-index, auto);
}`;function Cn(){var e=It,t=Lt,n=F.cssPrefix,r=F.replacementClass,i=Sn;if(n!==e||r!==t){var a=RegExp(`\\.${e}\\-`,`g`),o=RegExp(`\\--${e}\\-`,`g`),s=RegExp(`\\.${t}`,`g`);i=i.replace(a,`.${n}-`).replace(o,`--${n}-`).replace(s,`.${r}`)}return i}var wn=!1;function Tn(){F.autoAddCss&&!wn&&(pn(Cn()),wn=!0)}var En={mixout:function e(){return{dom:{css:Cn,insertCss:Tn}}},hooks:function e(){return{beforeDOMElementCreation:function e(){Tn()},beforeI2svg:function e(){Tn()}}}},V=C||{};V[A]||(V[A]={}),V[A].styles||(V[A].styles={}),V[A].hooks||(V[A].hooks={}),V[A].shims||(V[A].shims=[]);var H=V[A],Dn=[],On=function e(){w.removeEventListener(`DOMContentLoaded`,On),kn=1,Dn.map(function(e){return e()})},kn=!1;T&&(kn=(w.documentElement.doScroll?/^loaded|^c/:/^loaded|^i|^c/).test(w.readyState),kn||w.addEventListener(`DOMContentLoaded`,On));function An(e){T&&(kn?setTimeout(e,0):Dn.push(e))}function U(e){var t=e.tag,n=e.attributes,r=n===void 0?{}:n,i=e.children,a=i===void 0?[]:i;return typeof e==`string`?_n(e):`<${t} ${vn(r)}>${a.map(U).join(``)}</${t}>`}function jn(e,t,n){if(e&&e[t]&&e[t][n])return{prefix:t,iconName:n,icon:e[t][n]}}var Mn=function e(t,n){return function(e,r,i,a){return t.call(n,e,r,i,a)}},Nn=function e(t,n,r,i){var a=Object.keys(t),o=a.length,s=i===void 0?n:Mn(n,i),c,l,u;for(r===void 0?(c=1,u=t[a[0]]):(c=0,u=r);c<o;c++)l=a[c],u=s(u,t[l],l,t);return u};function Pn(e){return _(e).length===1?e.codePointAt(0).toString(16):null}function Fn(e){return Object.keys(e).reduce(function(t,n){var r=e[n];return r.icon?t[r.iconName]=r.icon:t[n]=r,t},{})}function In(e,t){var n=(arguments.length>2&&arguments[2]!==void 0?arguments[2]:{}).skipHooks,r=n===void 0?!1:n,i=Fn(t);typeof H.hooks.addPack==`function`&&!r?H.hooks.addPack(e,Fn(t)):H.styles[e]=m(m({},H.styles[e]||{}),i),e===`fas`&&In(`fa`,t)}var Ln=1,W=2,Rn=[[W,/* @__PURE__ */ S(/path opacity="([^"]*)".*d="([^"]*)".*path.*d="([^"]*)"/,{d2:2,d1:3})],[W,/* @__PURE__ */ S(/path opacity="([^"]*)".*d="([^"]*)"/,{d2:2})],[Ln,/* @__PURE__ */ S(/path fill="currentColor".*d="([^"]+)"/,{d1:1})]],zn=[[W,/* @__PURE__ */ S(/path class="([^"]*secondary[^"]*)".*d="([^"]+)".*path class="([^"]*primary[^"]*)".*d="([^"]+)"/,{attr2:1,d2:2,attr1:3,d1:4})],[W,/* @__PURE__ */ S(/path class="([^"]*primary[^"]*)".*d="([^"]+)".*path class="([^"]*secondary[^"]*)".*d="([^"]+)"/,{attr1:1,d1:2,attr2:3,d2:4})],[W,/* @__PURE__ */ S(/path class="([^"]*primary[^"]*)".*d="([^"]+)"/,{attr1:1,d1:2})],[W,/* @__PURE__ */ S(/path class="([^"]*secondary[^"]*)".*d="([^"]+)"/,{attr2:1,d2:2})],[W,/* @__PURE__ */ S(/path d="([^"]+)".*class="([^"]*secondary[^"]*)".*path d="([^"]+)".*class="([^"]*primary[^"]*)"/,{d2:1,attr2:2,d1:3,attr1:4})],[W,/* @__PURE__ */ S(/path d="([^"]+)".*class="([^"]*primary[^"]*)".*path d="([^"]+)".*class="([^"]*secondary[^"]*)"/,{d1:1,attr1:2,d2:3,attr2:4})],[W,/* @__PURE__ */ S(/path d="([^"]+)".*class="([^"]*primary[^"]*)"/,{d1:1,attr1:2})],[W,/* @__PURE__ */ S(/path d="([^"]+)".*class="([^"]*secondary[^"]*)"/,{d2:1,attr2:2})],[W,/* @__PURE__ */ S(/path d="([^"]+)".*path d="([^"]+)"/,{d1:1,d2:2})],[Ln,/* @__PURE__ */ S(/path d="([^"]+)"/,{d1:1})],[Ln,/* @__PURE__ */ S(/path style="([^"]+)".*d="([^"]+)"/,{attr1:1,d1:2})]],G=H.styles,Bn=H.shims,Vn=Object.keys(Qt),Hn=Vn.reduce(function(e,t){return e[t]=Object.keys(Qt[t]),e},{}),Un=null,Wn={},Gn={},Kn={},qn={},Jn={};function Yn(e){return~cn.indexOf(e)}function Xn(e,t){var n=t.split(`-`),r=n[0],i=n.slice(1).join(`-`);return r===e&&i!==``&&!Yn(i)?i:null}var Zn=function e(){var t=function e(t){return Nn(G,function(e,n,r){return e[r]=Nn(n,t,{}),e},{})};Wn=t(function(e,t,n){return t[3]&&(e[t[3]]=n),t[2]&&t[2].filter(function(e){return typeof e==`number`}).forEach(function(t){e[t.toString(16)]=n}),e}),Gn=t(function(e,t,n){return e[n]=n,t[2]&&t[2].filter(function(e){return typeof e==`string`}).forEach(function(t){e[t]=n}),e}),Jn=t(function(e,t,n){var r=t[2];return e[n]=n,r.forEach(function(t){e[t]=n}),e});var n=`far`in G||F.autoFetchSvg,r=Nn(Bn,function(e,t){var r=t[0],i=t[1],a=t[2];return i===`far`&&!n&&(i=`fas`),typeof r==`string`&&(e.names[r]={prefix:i,iconName:a}),typeof r==`number`&&(e.unicodes[r.toString(16)]={prefix:i,iconName:a}),e},{names:{},unicodes:{}});Kn=r.names,qn=r.unicodes,Un=ir(F.styleDefault,{family:F.familyDefault})};fn(function(e){Un=ir(e.styleDefault,{family:F.familyDefault})}),Zn();function Qn(e,t){return(Wn[e]||{})[t]}function $n(e,t){return(Gn[e]||{})[t]}function K(e,t){return(Jn[e]||{})[t]}function er(e){return Kn[e]||{prefix:null,iconName:null}}function tr(e){var t=qn[e],n=Qn(`fas`,e);return t||(n?{prefix:`fas`,iconName:n}:null)||{prefix:null,iconName:null}}function q(){return Un}var nr=function e(){return{prefix:null,iconName:null,rest:[]}};function rr(e){var t=E,n=Vn.reduce(function(e,t){return e[t]=`${F.cssPrefix}-${t}`,e},{});return lt.forEach(function(r){(e.includes(n[r])||e.some(function(e){return Hn[r].includes(e)}))&&(t=r)}),t}function ir(e){var t=(arguments.length>1&&arguments[1]!==void 0?arguments[1]:{}).family,n=t===void 0?E:t,r=Jt[n][e];if(n===D&&!e)return`fad`;var i=Xt[n][e]||Xt[n][r],a=e in H.styles?e:null;return i||a||null}function ar(e){var t=[],n=null;return e.forEach(function(e){var r=Xn(F.cssPrefix,e);r?n=r:e&&t.push(e)}),{iconName:n,rest:t}}function or(e){return e.sort().filter(function(e,t,n){return n.indexOf(e)===t})}var sr=kt.concat(ht);function cr(e){var t=(arguments.length>1&&arguments[1]!==void 0?arguments[1]:{}).skipLookups,n=t===void 0?!1:t,r=null,i=or(e.filter(function(e){return sr.includes(e)})),a=or(e.filter(function(e){return!sr.includes(e)})),o=g(i.filter(function(e){return r=e,!ge.includes(e)}),1)[0],s=o===void 0?null:o,c=rr(i),l=m(m({},ar(a)),{},{prefix:ir(s,{family:c})});return m(m(m({},l),fr({values:e,family:c,styles:G,config:F,canonical:l,givenPrefix:r})),lr(n,r,l))}function lr(e,t,n){var r=n.prefix,i=n.iconName;if(e||!r||!i)return{prefix:r,iconName:i};var a=t===`fa`?er(i):{},o=K(r,i);return i=a.iconName||o||i,r=a.prefix||r,r===`far`&&!G.far&&G.fas&&!F.autoFetchSvg&&(r=`fas`),{prefix:r,iconName:i}}var ur=lt.filter(function(e){return e!==E||e!==D}),dr=Object.keys(Ot).filter(function(e){return e!==E}).map(function(e){return Object.keys(Ot[e])}).flat();function fr(e){var t=e.values,n=e.family,r=e.canonical,i=e.givenPrefix,a=i===void 0?``:i,o=e.styles,s=o===void 0?{}:o,c=e.config,l=c===void 0?{}:c,u=n===D,d=t.includes(`fa-duotone`)||t.includes(`fad`),f=l.familyDefault===`duotone`,p=r.prefix===`fad`||r.prefix===`fa-duotone`;return!u&&(d||f||p)&&(r.prefix=`fad`),(t.includes(`fa-brands`)||t.includes(`fab`))&&(r.prefix=`fab`),!r.prefix&&ur.includes(n)&&(Object.keys(s).find(function(e){return dr.includes(e)})||l.autoFetchSvg)&&(r.prefix=pt.get(n).defaultShortPrefixId,r.iconName=K(r.prefix,r.iconName)||r.iconName),(r.prefix===`fa`||a===`fa`)&&(r.prefix=q()||`fas`),r}var pr=/* @__PURE__ */ function(){function e(){r(this,e),this.definitions={}}return a(e,[{key:`add`,value:function e(){var t=this,n=[...arguments].reduce(this._pullDefinitions,{});Object.keys(n).forEach(function(e){t.definitions[e]=m(m({},t.definitions[e]||{}),n[e]),In(e,n[e]);var r=Qt[E][e];r&&In(r,n[e]),Zn()})}},{key:`reset`,value:function e(){this.definitions={}}},{key:`_pullDefinitions`,value:function e(t,n){var r=n.prefix&&n.iconName&&n.icon?{0:n}:n;return Object.keys(r).map(function(e){var n=r[e],i=n.prefix,a=n.iconName,o=n.icon,s=o[2];t[i]||(t[i]={}),s.length>0&&s.forEach(function(e){typeof e==`string`&&(t[i][e]=o)}),t[i][a]=o}),t}}])}(),mr=[],J={},Y={},hr=Object.keys(Y);function gr(e,t){var n=t.mixoutsTo;return mr=e,J={},Object.keys(Y).forEach(function(e){hr.indexOf(e)===-1&&delete Y[e]}),mr.forEach(function(e){var t=e.mixout?e.mixout():{};if(Object.keys(t).forEach(function(e){typeof t[e]==`function`&&(n[e]=t[e]),b(t[e])===`object`&&Object.keys(t[e]).forEach(function(r){n[e]||(n[e]={}),n[e][r]=t[e][r]})}),e.hooks){var r=e.hooks();Object.keys(r).forEach(function(e){J[e]||(J[e]=[]),J[e].push(r[e])})}e.provides&&e.provides(Y)}),n}function _r(e,t){var n=[...arguments].slice(2);return(J[e]||[]).forEach(function(e){t=e.apply(null,[t].concat(n))}),t}function X(e){var t=[...arguments].slice(1);(J[e]||[]).forEach(function(e){e.apply(null,t)})}function Z(){var e=arguments[0],t=Array.prototype.slice.call(arguments,1);return Y[e]?Y[e].apply(null,t):void 0}function vr(e){e.prefix===`fa`&&(e.prefix=`fas`);var t=e.iconName,n=e.prefix||q();if(t)return t=K(n,t)||t,jn(yr.definitions,n,t)||jn(H.styles,n,t)}var yr=new pr,Q={noAuto:function e(){F.autoReplaceSvg=!1,F.observeMutations=!1,X(`noAuto`)},config:F,dom:{i2svg:function e(){var t=arguments.length>0&&arguments[0]!==void 0?arguments[0]:{};return T?(X(`beforeI2svg`,t),Z(`pseudoElements2svg`,t),Z(`i2svg`,t)):Promise.reject(/* @__PURE__ */ Error(`Operation requires a DOM of some kind.`))},watch:function e(){var t=arguments.length>0&&arguments[0]!==void 0?arguments[0]:{},n=t.autoReplaceSvgRoot;F.autoReplaceSvg===!1&&(F.autoReplaceSvg=!0),F.observeMutations=!0,An(function(){br({autoReplaceSvgRoot:n}),X(`watch`,t)})}},parse:{icon:function e(t){if(t===null)return null;if(b(t)===`object`&&t.prefix&&t.iconName)return{prefix:t.prefix,iconName:K(t.prefix,t.iconName)||t.iconName};if(Array.isArray(t)&&t.length===2){var n=t[1].indexOf(`fa-`)===0?t[1].slice(3):t[1],r=ir(t[0]);return{prefix:r,iconName:K(r,n)||n}}if(typeof t==`string`&&(t.indexOf(`${F.cssPrefix}-`)>-1||t.match(tn))){var i=cr(t.split(` `),{skipLookups:!0});return{prefix:i.prefix||q(),iconName:K(i.prefix,i.iconName)||i.iconName}}if(typeof t==`string`){var a=q();return{prefix:a,iconName:K(a,t)||t}}}},library:yr,findIconDefinition:vr,toHtml:U},br=function e(){var t=(arguments.length>0&&arguments[0]!==void 0?arguments[0]:{}).autoReplaceSvgRoot,n=t===void 0?w:t;(Object.keys(H.styles).length>0||F.autoFetchSvg)&&T&&F.autoReplaceSvg&&Q.dom.i2svg({node:n})};function xr(e,t){return Object.defineProperty(e,"abstract",{get:t}),Object.defineProperty(e,"html",{get:function t(){return e.abstract.map(function(e){return U(e)})}}),Object.defineProperty(e,"node",{get:function t(){if(T){var n=w.createElement(`div`);return n.innerHTML=e.html,n.children}}}),e}function Sr(e){var t=e.children,n=e.main,r=e.mask,i=e.attributes,a=e.styles,o=e.transform;if(yn(o)&&n.found&&!r.found){var s={x:n.width/n.height/2,y:.5};i.style=B(m(m({},a),{},{"transform-origin":`${s.x+o.x/16}em ${s.y+o.y/16}em`}))}return[{tag:`svg`,attributes:i,children:t}]}function Cr(e){var t=e.prefix,n=e.iconName,r=e.children,i=e.attributes,a=e.symbol,o=a===!0?`${t}-${F.cssPrefix}-${n}`:a;return[{tag:`svg`,attributes:{style:`display: none;`},children:[{tag:`symbol`,attributes:m(m({},i),{},{id:o}),children:r}]}]}function wr(e){return[`aria-label`,`aria-labelledby`,`title`,`role`].some(function(t){return t in e})}function Tr(e){var t=e.icons,n=t.main,r=t.mask,i=e.prefix,a=e.iconName,o=e.transform,s=e.symbol,c=e.maskId,l=e.extra,u=e.watchable,d=u===void 0?!1:u,f=r.found?r:n,p=f.width,h=f.height,g=[F.replacementClass,a?`${F.cssPrefix}-${a}`:``].filter(function(e){return l.classes.indexOf(e)===-1}).filter(function(e){return e!==``||!!e}).concat(l.classes).join(` `),_={children:[],attributes:m(m({},l.attributes),{},{"data-prefix":i,"data-icon":a,class:g,role:l.attributes.role||`img`,viewBox:`0 0 ${p} ${h}`})};!wr(l.attributes)&&!l.attributes[`aria-hidden`]&&(_.attributes[`aria-hidden`]=`true`),d&&(_.attributes[j]=``);var v=m(m({},_),{},{prefix:i,iconName:a,main:n,mask:r,maskId:c,transform:o,symbol:s,styles:m({},l.styles)}),y=r.found&&n.found?Z(`generateAbstractMask`,v)||{children:[],attributes:{}}:Z(`generateAbstractIcon`,v)||{children:[],attributes:{}},b=y.children,x=y.attributes;return v.children=b,v.attributes=x,s?Cr(v):Sr(v)}function Er(e){var t=e.content,n=e.width,r=e.height,i=e.transform,a=e.extra,o=e.watchable,s=o===void 0?!1:o,c=m(m({},a.attributes),{},{class:a.classes.join(` `)});s&&(c[j]=``);var l=m({},a.styles);yn(i)&&(l.transform=xn({transform:i,startCentered:!0,width:n,height:r}),l[`-webkit-transform`]=l.transform);var u=B(l);u.length>0&&(c.style=u);var d=[];return d.push({tag:`span`,attributes:c,children:[t]}),d}function Dr(e){var t=e.content,n=e.extra,r=m(m({},n.attributes),{},{class:n.classes.join(` `)}),i=B(n.styles);i.length>0&&(r.style=i);var a=[];return a.push({tag:`span`,attributes:r,children:[t]}),a}var Or=H.styles;function kr(e){var t=e[0],n=e[1],r=g(e.slice(4),1)[0],i=null;return i=Array.isArray(r)?{tag:`g`,attributes:{class:`${F.cssPrefix}-${sn.GROUP}`},children:[{tag:`path`,attributes:{class:`${F.cssPrefix}-${sn.SECONDARY}`,fill:`currentColor`,d:r[0]}},{tag:`path`,attributes:{class:`${F.cssPrefix}-${sn.PRIMARY}`,fill:`currentColor`,d:r[1]}}]}:{tag:`path`,attributes:{fill:`currentColor`,d:r}},{found:!0,width:t,height:n,icon:i}}var Ar={found:!1,width:512,height:512};function jr(e,t){!Kt&&!F.showMissingIcons&&e&&console.error(`Icon with name "${e}" and prefix "${t}" is missing.`)}function Mr(e,t){var n=t;return t===`fa`&&F.styleDefault!==null&&(t=q()),new Promise(function(r,i){if(n===`fa`){var a=er(e)||{};e=a.iconName||e,t=a.prefix||t}if(e&&t&&Or[t]&&Or[t][e]){var o=Or[t][e];return r(kr(o))}jr(e,t),r(m(m({},Ar),{},{icon:F.showMissingIcons&&e&&Z(`missingIconAbstract`)||{}}))})}var Nr=function e(){},Pr=F.measurePerformance&&ce&&ce.mark&&ce.measure?ce:{mark:Nr,measure:Nr},$=`FA "7.3.0"`,Fr=function e(t){return Pr.mark(`${$} ${t} begins`),function(){return Ir(t)}},Ir=function e(t){Pr.mark(`${$} ${t} ends`),Pr.measure(`${$} ${t}`,`${$} ${t} begins`,`${$} ${t} ends`)},Lr={begin:Fr,end:Ir},Rr=function e(){};function zr(e){return typeof(e.getAttribute?e.getAttribute(j):null)==`string`}function Br(e){var t=e.getAttribute?e.getAttribute(Bt):null,n=e.getAttribute?e.getAttribute(Vt):null;return t&&n}function Vr(e){return e&&e.classList&&e.classList.contains&&e.classList.contains(F.replacementClass)}function Hr(){return F.autoReplaceSvg===!0?qr.replace:qr[F.autoReplaceSvg]||qr.replace}function Ur(e){return w.createElementNS(`http://www.w3.org/2000/svg`,e)}function Wr(e){return w.createElement(e)}function Gr(e){var t=(arguments.length>1&&arguments[1]!==void 0?arguments[1]:{}).ceFn,n=t===void 0?e.tag===`svg`?Ur:Wr:t;if(typeof e==`string`)return w.createTextNode(e);var r=n(e.tag);return Object.keys(e.attributes||[]).forEach(function(t){r.setAttribute(t,e.attributes[t])}),(e.children||[]).forEach(function(e){r.appendChild(Gr(e,{ceFn:n}))}),r}function Kr(e){var t=` ${e.outerHTML} `;return t=`${t}Font Awesome fontawesome.com `,t}var qr={replace:function e(t){var n=t[0];if(n.parentNode)if(t[1].forEach(function(e){n.parentNode.insertBefore(Gr(e),n)}),n.getAttribute(j)===null&&F.keepOriginalSource){var r=w.createComment(Kr(n));n.parentNode.replaceChild(r,n)}else n.remove()},nest:function e(t){var n=t[0],r=t[1];if(~gn(n).indexOf(F.replacementClass))return qr.replace(t);var i=RegExp(`${F.cssPrefix}-.*`);if(delete r[0].attributes.id,r[0].attributes.class){var a=r[0].attributes.class.split(` `).reduce(function(e,t){return t===F.replacementClass||t.match(i)?e.toSvg.push(t):e.toNode.push(t),e},{toNode:[],toSvg:[]});r[0].attributes.class=a.toSvg.join(` `),a.toNode.length===0?n.removeAttribute(`class`):n.setAttribute(`class`,a.toNode.join(` `))}var o=r.map(function(e){return U(e)}).join(`
`);n.setAttribute(j,``),n.innerHTML=o}};function Jr(e){e()}function Yr(e,t){var n=typeof t==`function`?t:Rr;if(e.length===0)n();else{var r=Jr;F.mutateApproach===Ut&&(r=C.requestAnimationFrame||Jr),r(function(){var t=Hr(),r=Lr.begin(`mutate`);e.map(t),r(),n()})}}var Xr=!1;function Zr(){Xr=!0}function Qr(){Xr=!1}var $r=null;function ei(e){if(se&&F.observeMutations){var t=e.treeCallback,n=t===void 0?Rr:t,r=e.nodeCallback,i=r===void 0?Rr:r,a=e.pseudoElementsCallback,o=a===void 0?Rr:a,s=e.observeMutationsRoot,c=s===void 0?w:s;$r=new se(function(e){if(!Xr){var t=q();z(e).forEach(function(e){if(e.type===`childList`&&e.addedNodes.length>0&&!zr(e.addedNodes[0])&&(F.searchPseudoElements&&o(e.target),n(e.target)),e.type===`attributes`&&e.target.parentNode&&F.searchPseudoElements&&o([e.target],!0),e.type===`attributes`&&zr(e.target)&&~on.indexOf(e.attributeName))if(e.attributeName===`class`&&Br(e.target)){var r=cr(gn(e.target)),a=r.prefix,s=r.iconName;e.target.setAttribute(Bt,a||t),s&&e.target.setAttribute(Vt,s)}else Vr(e.target)&&i(e.target)})}}),T&&$r.observe(c,{childList:!0,attributes:!0,characterData:!0,subtree:!0})}}function ti(){$r&&$r.disconnect()}function ni(e){var t=e.getAttribute(`style`),n=[];return t&&(n=t.split(`;`).reduce(function(e,t){var n=t.split(`:`),r=n[0],i=n.slice(1);return r&&i.length>0&&(e[r]=i.join(`:`).trim()),e},{})),n}function ri(e){var t=e.getAttribute(`data-prefix`),n=e.getAttribute(`data-icon`),r=e.innerText===void 0?``:e.innerText.trim(),i=cr(gn(e));return i.prefix||(i.prefix=q()),t&&n&&(i.prefix=t,i.iconName=n),i.iconName&&i.prefix?i:(i.prefix&&r.length>0&&(i.iconName=$n(i.prefix,e.innerText)||Qn(i.prefix,Pn(e.innerText))),!i.iconName&&F.autoFetchSvg&&e.firstChild&&e.firstChild.nodeType===Node.TEXT_NODE&&(i.iconName=e.firstChild.data),i)}function ii(e){return z(e.attributes).reduce(function(e,t){return e.name!==`class`&&e.name!==`style`&&(e[t.name]=t.value),e},{})}function ai(){return{iconName:null,prefix:null,transform:R,symbol:!1,mask:{iconName:null,prefix:null,rest:[]},maskId:null,extra:{classes:[],styles:{},attributes:{}}}}function oi(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{styleParser:!0},n=ri(e),r=n.iconName,i=n.prefix,a=n.rest,o=ii(e),s=_r(`parseNodeAttributes`,{},e);return m({iconName:r,prefix:i,transform:R,mask:{iconName:null,prefix:null,rest:[]},maskId:null,symbol:!1,extra:{classes:a,styles:t.styleParser?ni(e):[],attributes:o}},s)}var si=H.styles;function ci(e){var t=F.autoReplaceSvg===`nest`?oi(e,{styleParser:!1}):oi(e);return~t.extra.classes.indexOf(nn)?Z(`generateLayersText`,e,t):Z(`generateSvgReplacementMutation`,e,t)}function li(){return[].concat(_(ht),_(kt))}function ui(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:null;if(!T)return Promise.resolve();var n=w.documentElement.classList,r=function e(t){return n.add(`${Ht}-${t}`)},i=function e(t){return n.remove(`${Ht}-${t}`)},a=F.autoFetchSvg?li():ge.concat(Object.keys(si));a.includes(`fa`)||a.push(`fa`);var o=[`.${nn}:not([${j}])`].concat(a.map(function(e){return`.${e}:not([${j}])`})).join(`, `);if(o.length===0)return Promise.resolve();var s=[];try{s=z(e.querySelectorAll(o))}catch(e){}if(s.length>0)r(`pending`),i(`complete`);else return Promise.resolve();var c=Lr.begin(`onTree`),l=s.reduce(function(e,t){try{var n=ci(t);n&&e.push(n)}catch(e){Kt||e.name===`MissingIcon`&&console.error(e)}return e},[]);return new Promise(function(e,n){Promise.all(l).then(function(n){Yr(n,function(){r(`active`),r(`complete`),i(`pending`),typeof t==`function`&&t(),c(),e()})}).catch(function(e){c(),n(e)})})}function di(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:null;ci(e).then(function(e){e&&Yr([e],t)})}function fi(e){return function(t){var n=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},r=(t||{}).icon?t:vr(t||{}),i=n.mask;return i&&(i=(i||{}).icon?i:vr(i||{})),e(r,m(m({},n),{},{mask:i}))}}var pi=function e(t){var n=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},r=n.transform,i=r===void 0?R:r,a=n.symbol,o=a===void 0?!1:a,s=n.mask,c=s===void 0?null:s,l=n.maskId,u=l===void 0?null:l,d=n.classes,f=d===void 0?[]:d,p=n.attributes,h=p===void 0?{}:p,g=n.styles,_=g===void 0?{}:g;if(t){var v=t.prefix,y=t.iconName,b=t.icon;return xr(m({type:`icon`},t),function(){return X(`beforeDOMElementCreation`,{iconDefinition:t,params:n}),Tr({icons:{main:kr(b),mask:c?kr(c.icon):{found:!1,width:null,height:null,icon:{}}},prefix:v,iconName:y,transform:m(m({},R),i),symbol:o,maskId:u,extra:{attributes:h,styles:_,classes:f}})})}},mi={mixout:function e(){return{icon:fi(pi)}},hooks:function e(){return{mutationObserverCallbacks:function e(t){return t.treeCallback=ui,t.nodeCallback=di,t}}},provides:function e(t){t.i2svg=function(e){var t=e.node,n=t===void 0?w:t,r=e.callback;return ui(n,r===void 0?function(){}:r)},t.generateSvgReplacementMutation=function(e,t){var n=t.iconName,r=t.prefix,i=t.transform,a=t.symbol,o=t.mask,s=t.maskId,c=t.extra;return new Promise(function(t,l){Promise.all([Mr(n,r),o.iconName?Mr(o.iconName,o.prefix):Promise.resolve({found:!1,width:512,height:512,icon:{}})]).then(function(o){var l=g(o,2),u=l[0],d=l[1];t([e,Tr({icons:{main:u,mask:d},prefix:r,iconName:n,transform:i,symbol:a,maskId:s,extra:c,watchable:!0})])}).catch(l)})},t.generateAbstractIcon=function(e){var t=e.children,n=e.attributes,r=e.main,i=e.transform,a=e.styles,o=B(a);o.length>0&&(n.style=o);var s;return yn(i)&&(s=Z(`generateAbstractTransformGrouping`,{main:r,transform:i,containerWidth:r.width,iconWidth:r.width})),t.push(s||r.icon),{children:t,attributes:n}}}},hi={mixout:function e(){return{layer:function e(t){var n=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},r=n.classes,i=r===void 0?[]:r;return xr({type:`layer`},function(){X(`beforeDOMElementCreation`,{assembler:t,params:n});var e=[];return t(function(t){Array.isArray(t)?t.map(function(t){e=e.concat(t.abstract)}):e=e.concat(t.abstract)}),[{tag:`span`,attributes:{class:[`${F.cssPrefix}-layers`].concat(_(i)).join(` `)},children:e}]})}}}},gi={mixout:function e(){return{counter:function e(t){var n=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},r=n.title,i=r===void 0?null:r,a=n.classes,o=a===void 0?[]:a,s=n.attributes,c=s===void 0?{}:s,l=n.styles,u=l===void 0?{}:l;return xr({type:`counter`,content:t},function(){return X(`beforeDOMElementCreation`,{content:t,params:n}),Dr({content:t.toString(),title:i,extra:{attributes:c,styles:u,classes:[`${F.cssPrefix}-layers-counter`].concat(_(o))}})})}}}},_i={mixout:function e(){return{text:function e(t){var n=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},r=n.transform,i=r===void 0?R:r,a=n.classes,o=a===void 0?[]:a,s=n.attributes,c=s===void 0?{}:s,l=n.styles,u=l===void 0?{}:l;return xr({type:`text`,content:t},function(){return X(`beforeDOMElementCreation`,{content:t,params:n}),Er({content:t,transform:m(m({},R),i),extra:{attributes:c,styles:u,classes:[`${F.cssPrefix}-layers-text`].concat(_(o))}})})}}},provides:function e(t){t.generateLayersText=function(e,t){var n=t.transform,r=t.extra,i=null,a=null;if(ue){var o=parseInt(getComputedStyle(e).fontSize,10),s=e.getBoundingClientRect();i=s.width/o,a=s.height/o}return Promise.resolve([e,Er({content:e.innerHTML,width:i,height:a,transform:n,extra:r,watchable:!0})])}}},vi=/* @__PURE__ */ RegExp(`"`,`ug`),yi=[1105920,1112319],bi=m(m(m(m({},{FontAwesome:{normal:`fas`,400:`fas`}}),ft),Pt),bt),xi=Object.keys(bi).reduce(function(e,t){return e[t.toLowerCase()]=bi[t],e},{}),Si=Object.keys(xi).reduce(function(e,t){var n=xi[t];return e[t]=n[900]||_(Object.entries(n))[0][1],e},{});function Ci(e){return Pn(_(e.replace(vi,``))[0]||``)}function wi(e){var t=e.getPropertyValue(`font-feature-settings`).includes(`ss01`),n=e.getPropertyValue(`content`).replace(vi,``),r=n.codePointAt(0),i=r>=yi[0]&&r<=yi[1],a=n.length===2?n[0]===n[1]:!1;return i||a||t}function Ti(e,t){var n=e.replace(/^['"]|['"]$/g,``).toLowerCase(),r=parseInt(t),i=isNaN(r)?`normal`:r;return(xi[n]||{})[i]||Si[n]}function Ei(e,t){var n=`${zt}${t.replace(`:`,`-`)}`;return new Promise(function(r,i){if(e.getAttribute(n)!==null)return r();var a=z(e.children).filter(function(e){return e.getAttribute(Rt)===t})[0],o=C.getComputedStyle(e,t),s=o.getPropertyValue(`font-family`),c=s.match(rn),l=o.getPropertyValue(`font-weight`),u=o.getPropertyValue(`content`);if(a&&!c)return e.removeChild(a),r();if(c&&u!==`none`&&u!==``){var d=o.getPropertyValue(`content`),f=Ti(s,l),p=Ci(d),h=c[0].startsWith(`FontAwesome`),g=wi(o),_=Qn(f,p),v=_;if(h){var y=tr(p);y.iconName&&y.prefix&&(_=y.iconName,f=y.prefix)}if(_&&!g&&(!a||a.getAttribute(Bt)!==f||a.getAttribute(Vt)!==v)){e.setAttribute(n,v),a&&e.removeChild(a);var b=ai(),x=b.extra;x.attributes[Rt]=t,Mr(_,f).then(function(i){var a=Tr(m(m({},b),{},{icons:{main:i,mask:nr()},prefix:f,iconName:v,extra:x,watchable:!0})),o=w.createElementNS(`http://www.w3.org/2000/svg`,`svg`);t===`::before`?e.insertBefore(o,e.firstChild):e.appendChild(o),o.outerHTML=a.map(function(e){return U(e)}).join(`
`),e.removeAttribute(n),r()}).catch(i)}else r()}else r()})}function Di(e){return Promise.all([Ei(e,`::before`),Ei(e,`::after`)])}function Oi(e){return e.parentNode!==document.head&&!~Wt.indexOf(e.tagName.toUpperCase())&&!e.getAttribute(Rt)&&(!e.parentNode||e.parentNode.tagName!==`svg`)}var ki=function e(t){return!!t&&Gt.some(function(e){return t.includes(e)})},Ai=function e(t){if(!t)return[];var n=/* @__PURE__ */ new Set,r=t.split(/,(?![^()]*\))/).map(function(e){return e.trim()});r=r.flatMap(function(e){return e.includes(`(`)?e:e.split(`,`).map(function(e){return e.trim()})});var i=o(r),a;try{for(i.s();!(a=i.n()).done;){var s=a.value;if(ki(s)){var c=Gt.reduce(function(e,t){return e.replace(t,``)},s);c!==``&&c!==`*`&&n.add(c)}}}catch(e){i.e(e)}finally{i.f()}return n};function ji(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:!1;if(T){var n;if(t)n=e;else if(F.searchPseudoElementsFullScan)n=e.querySelectorAll(`*`);else{var r=/* @__PURE__ */ new Set,i=o(document.styleSheets),a;try{for(i.s();!(a=i.n()).done;){var s=a.value;try{var c=o(s.cssRules),l;try{for(c.s();!(l=c.n()).done;){var u=l.value,d=o(Ai(u.selectorText)),f;try{for(d.s();!(f=d.n()).done;){var p=f.value;r.add(p)}}catch(e){d.e(e)}finally{d.f()}}}catch(e){c.e(e)}finally{c.f()}}catch(e){F.searchPseudoElementsWarnings&&console.warn(`Font Awesome: cannot parse stylesheet: ${s.href} (${e.message})
If it declares any Font Awesome CSS pseudo-elements, they will not be rendered as SVG icons. Add crossorigin="anonymous" to the <link>, enable searchPseudoElementsFullScan for slower but more thorough DOM parsing, or suppress this warning by setting searchPseudoElementsWarnings to false.`)}}}catch(e){i.e(e)}finally{i.f()}if(!r.size)return;var m=Array.from(r).join(`, `);try{n=e.querySelectorAll(m)}catch(e){}}return new Promise(function(e,t){var r=z(n).filter(Oi).map(Di),i=Lr.begin(`searchPseudoElements`);Zr(),Promise.all(r).then(function(){i(),Qr(),e()}).catch(function(){i(),Qr(),t()})})}}var Mi={hooks:function e(){return{mutationObserverCallbacks:function e(t){return t.pseudoElementsCallback=ji,t}}},provides:function e(t){t.pseudoElements2svg=function(e){var t=e.node,n=t===void 0?w:t;F.searchPseudoElements&&ji(n)}}},Ni=!1,Pi={mixout:function e(){return{dom:{unwatch:function e(){Zr(),Ni=!0}}}},hooks:function e(){return{bootstrap:function e(){ei(_r(`mutationObserverCallbacks`,{}))},noAuto:function e(){ti()},watch:function e(t){var n=t.observeMutationsRoot;Ni?Qr():ei(_r(`mutationObserverCallbacks`,{observeMutationsRoot:n}))}}}},Fi=function e(t){return t.toLowerCase().split(` `).reduce(function(e,t){var n=t.toLowerCase().split(`-`),r=n[0],i=n.slice(1).join(`-`);if(r&&i===`h`)return e.flipX=!0,e;if(r&&i===`v`)return e.flipY=!0,e;if(i=parseFloat(i),isNaN(i))return e;switch(r){case`grow`:e.size+=i;break;case`shrink`:e.size-=i;break;case`left`:e.x-=i;break;case`right`:e.x+=i;break;case`up`:e.y-=i;break;case`down`:e.y+=i;break;case`rotate`:e.rotate+=i;break}return e},{size:16,x:0,y:0,flipX:!1,flipY:!1,rotate:0})},Ii={mixout:function e(){return{parse:{transform:function e(t){return Fi(t)}}}},hooks:function e(){return{parseNodeAttributes:function e(t,n){var r=n.getAttribute(`data-fa-transform`);return r&&(t.transform=Fi(r)),t}}},provides:function e(t){t.generateAbstractTransformGrouping=function(e){var t=e.main,n=e.transform,r=e.containerWidth,i=e.iconWidth,a={outer:{transform:`translate(${r/2} 256)`},inner:{transform:`${`translate(${n.x*32}, ${n.y*32}) `} ${`scale(${n.size/16*(n.flipX?-1:1)}, ${n.size/16*(n.flipY?-1:1)}) `} ${`rotate(${n.rotate} 0 0)`}`},path:{transform:`translate(${i/2*-1} -256)`}};return{tag:`g`,attributes:m({},a.outer),children:[{tag:`g`,attributes:m({},a.inner),children:[{tag:t.icon.tag,children:t.icon.children,attributes:m(m({},t.icon.attributes),a.path)}]}]}}}},Li={x:0,y:0,width:`100%`,height:`100%`};function Ri(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:!0;return e.attributes&&(e.attributes.fill||t)&&(e.attributes.fill=`black`),e}function zi(e){return e.tag===`g`?e.children:[e]}gr([En,mi,hi,gi,_i,Mi,Pi,Ii,{hooks:function e(){return{parseNodeAttributes:function e(t,n){var r=n.getAttribute(`data-fa-mask`),i=r?cr(r.split(` `).map(function(e){return e.trim()})):nr();return i.prefix||(i.prefix=q()),t.mask=i,t.maskId=n.getAttribute(`data-fa-mask-id`),t}}},provides:function e(t){t.generateAbstractMask=function(e){var t=e.children,n=e.attributes,r=e.main,i=e.mask,a=e.maskId,o=e.transform,s=r.width,c=r.icon,l=i.width,u=i.icon,d=bn({transform:o,containerWidth:l,iconWidth:s}),f={tag:`rect`,attributes:m(m({},Li),{},{fill:`white`})},p=c.children?{children:c.children.map(Ri)}:{},h={tag:`g`,attributes:m({},d.inner),children:[Ri(m({tag:c.tag,attributes:m(m({},c.attributes),d.path)},p))]},g={tag:`g`,attributes:m({},d.outer),children:[h]},_=`mask-${a||hn()}`,v=`clip-${a||hn()}`,y={tag:`mask`,attributes:m(m({},Li),{},{id:_,maskUnits:`userSpaceOnUse`,maskContentUnits:`userSpaceOnUse`}),children:[f,g]},b={tag:`defs`,children:[{tag:`clipPath`,attributes:{id:v},children:zi(u)},y]};return t.push(b,{tag:`rect`,attributes:m({fill:`currentColor`,"clip-path":`url(#${v})`,mask:`url(#${_})`},Li)}),{children:t,attributes:n}}}},{provides:function e(t){var n=!1;C.matchMedia&&(n=C.matchMedia(`(prefers-reduced-motion: reduce)`).matches),t.missingIconAbstract=function(){var e=[],t={fill:`currentColor`},r={attributeType:`XML`,repeatCount:`indefinite`,dur:`2s`};e.push({tag:`path`,attributes:m(m({},t),{},{d:`M156.5,447.7l-12.6,29.5c-18.7-9.5-35.9-21.2-51.5-34.9l22.7-22.7C127.6,430.5,141.5,440,156.5,447.7z M40.6,272H8.5 c1.4,21.2,5.4,41.7,11.7,61.1L50,321.2C45.1,305.5,41.8,289,40.6,272z M40.6,240c1.4-18.8,5.2-37,11.1-54.1l-29.5-12.6 C14.7,194.3,10,216.7,8.5,240H40.6z M64.3,156.5c7.8-14.9,17.2-28.8,28.1-41.5L69.7,92.3c-13.7,15.6-25.5,32.8-34.9,51.5 L64.3,156.5z M397,419.6c-13.9,12-29.4,22.3-46.1,30.4l11.9,29.8c20.7-9.9,39.8-22.6,56.9-37.6L397,419.6z M115,92.4 c13.9-12,29.4-22.3,46.1-30.4l-11.9-29.8c-20.7,9.9-39.8,22.6-56.8,37.6L115,92.4z M447.7,355.5c-7.8,14.9-17.2,28.8-28.1,41.5 l22.7,22.7c13.7-15.6,25.5-32.9,34.9-51.5L447.7,355.5z M471.4,272c-1.4,18.8-5.2,37-11.1,54.1l29.5,12.6 c7.5-21.1,12.2-43.5,13.6-66.8H471.4z M321.2,462c-15.7,5-32.2,8.2-49.2,9.4v32.1c21.2-1.4,41.7-5.4,61.1-11.7L321.2,462z M240,471.4c-18.8-1.4-37-5.2-54.1-11.1l-12.6,29.5c21.1,7.5,43.5,12.2,66.8,13.6V471.4z M462,190.8c5,15.7,8.2,32.2,9.4,49.2h32.1 c-1.4-21.2-5.4-41.7-11.7-61.1L462,190.8z M92.4,397c-12-13.9-22.3-29.4-30.4-46.1l-29.8,11.9c9.9,20.7,22.6,39.8,37.6,56.9 L92.4,397z M272,40.6c18.8,1.4,36.9,5.2,54.1,11.1l12.6-29.5C317.7,14.7,295.3,10,272,8.5V40.6z M190.8,50 c15.7-5,32.2-8.2,49.2-9.4V8.5c-21.2,1.4-41.7,5.4-61.1,11.7L190.8,50z M442.3,92.3L419.6,115c12,13.9,22.3,29.4,30.5,46.1 l29.8-11.9C470,128.5,457.3,109.4,442.3,92.3z M397,92.4l22.7-22.7c-15.6-13.7-32.8-25.5-51.5-34.9l-12.6,29.5 C370.4,72.1,384.4,81.5,397,92.4z`})});var i=m(m({},r),{},{attributeName:`opacity`}),a={tag:`circle`,attributes:m(m({},t),{},{cx:`256`,cy:`364`,r:`28`}),children:[]};return n||a.children.push({tag:`animate`,attributes:m(m({},r),{},{attributeName:`r`,values:`28;14;28;28;14;28;`})},{tag:`animate`,attributes:m(m({},i),{},{values:`1;0;1;1;0;1;`})}),e.push(a),e.push({tag:`path`,attributes:m(m({},t),{},{opacity:`1`,d:`M263.7,312h-16c-6.6,0-12-5.4-12-12c0-71,77.4-63.9,77.4-107.8c0-20-17.8-40.2-57.4-40.2c-29.1,0-44.3,9.6-59.2,28.7 c-3.9,5-11.1,6-16.2,2.4l-13.1-9.2c-5.6-3.9-6.9-11.8-2.6-17.2c21.2-27.2,46.4-44.7,91.2-44.7c52.3,0,97.4,29.8,97.4,80.2 c0,67.6-77.4,63.5-77.4,107.8C275.7,306.6,270.3,312,263.7,312z`}),children:n?[]:[{tag:`animate`,attributes:m(m({},i),{},{values:`1;0;0;0;0;1;`})}]}),n||e.push({tag:`path`,attributes:m(m({},t),{},{opacity:`0`,d:`M232.5,134.5l7,168c0.3,6.4,5.6,11.5,12,11.5h9c6.4,0,11.7-5.1,12-11.5l7-168c0.3-6.8-5.2-12.5-12-12.5h-23 C237.7,122,232.2,127.7,232.5,134.5z`}),children:[{tag:`animate`,attributes:m(m({},i),{},{values:`0;0;1;1;0;0;`})}]}),{tag:`g`,attributes:{class:`missing`},children:e}}}},{hooks:function e(){return{parseNodeAttributes:function e(t,n){var r=n.getAttribute(`data-fa-symbol`);return t.symbol=r===null?!1:r===``?!0:r,t}}}}],{mixoutsTo:Q});var Bi=Q.noAuto,Vi=Q.config,Hi=Q.library,Ui=Q.dom,Wi=Q.parse,Gi=Q.findIconDefinition,Ki=Q.toHtml,qi=Q.icon,Ji=Q.layer,Yi=Q.text,Xi=Q.counter;export{Q as api,Vi as config,Xi as counter,Ui as dom,Gi as findIconDefinition,qi as icon,Ji as layer,Hi as library,Bi as noAuto,Wi as parse,Yi as text,Ki as toHtml};

