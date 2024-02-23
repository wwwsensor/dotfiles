// ==UserScript==
// @name         Direct File for Google Classroom
// @namespace    http://tampermonkey.net
// @version      0.4.0
// @description  Directly Download the Files in Google Classroom using Ctrl Click
// @author       You
// @match        https://classroom.google.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=google.com
// @grant        none
// @license MIT
// @downloadURL https://update.greasyfork.org/scripts/442206/Direct%20File%20for%20Google%20Classroom.user.js
// @updateURL https://update.greasyfork.org/scripts/442206/Direct%20File%20for%20Google%20Classroom.meta.js
// ==/UserScript==

(function () {

  'use strict';
  // Your code here...

  const M_HREF = "https://drive.google.com/file/d/"



  new MutationObserver(() => {

    Promise.resolve().then(() => {

      const links = document.querySelectorAll(`[href*="${M_HREF}"]:not([data-ozhref])`)
      if (links.length > 0) {
        for (const linkElm of links) {

          const orhref = linkElm.href;

          linkElm.dataset.ozhref = orhref;

          const mres = orhref.match(/\https\:\/\/drive\.google\.com\/file\/d\/([0-9a-zA-Z\-\_\+]+)\/\w+/);
          if (!mres) return;


          let dfileId = `${mres[1]}`;

          // let newHref=`https://drive.google.com/u/1/uc?id=${mres[1]}&export=download`;


          let uo = null;
          try {
            uo = new URL(orhref);
          } catch (e) { }
          if (!uo) continue;

          let uo2 = new URL(`https://drive.google.com/uc?export=download&id=${dfileId}`);



          uo.searchParams.forEach((value, key) => {
            uo2.searchParams.set(key, value);
          });
          let newHref = uo2.toString()

          if (!newHref || typeof newHref !== 'string') continue;
          // console.log(orhref, newHref)
          // linkElm.setAttribute('href',newHref)

          // let newHref = `https://drive.google.com/uc?export=download&id=${dfileId}&usp=drive_web&authuser=2`
          linkElm.setAttribute('href', newHref)

          linkElm.setAttribute('target', '_blank')

          linkElm.addEventListener('click', function (evt) {

              const linkElm = this;
              evt.stopPropagation();
              evt.stopImmediatePropagation();


          }, true);




        }

      }

    });

  }).observe(document, { subtree: true, childList: true })




})();
