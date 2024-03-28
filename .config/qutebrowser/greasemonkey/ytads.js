// ==UserScript==
// @name         Working YouTube Ad Skipper
// @name:ja      youtube自動広告スキッパー
// @name:zh-CN      工作中的YouTube广告跳过器
// @namespace    https://greasyfork.org/users/1016463-vasu-noraneko217
// @version      4.4.2
// @description  Simple ad skipper for youtube immune to ad blocker restriction (This is not ad blocker)
// @description:ja youtubeの広告を自動スキップ
// @description:zh-CN 简单的YouTube广告跳过工具，免疫广告拦截器限制
// @author       Vasu_NoraNeko217
// @match        https://www.youtube.com/*
// @grant        none
// @license      MIT
// @downloadURL https://update.greasyfork.org/scripts/477383/Working%20YouTube%20Ad%20Skipper.user.js
// @updateURL https://update.greasyfork.org/scripts/477383/Working%20YouTube%20Ad%20Skipper.meta.js
// ==/UserScript==
var WYTAS_ver='4.4.2'
console.log("WYTAS:YouTube Ad Skipper by Vyasdev217 (https://greasyfork.org/en/users/1016463)");
function isEdge() {return navigator.userAgent.indexOf('Edg') !== -1;}
var is_edge=isEdge()
const observer = new MutationObserver((mutations) => {
  //if(window.location.toString().includes("shorts")){window.location="https://youtube.com"} // To block youtube shorts for better productivity
  mutations.forEach((mutation) => {
      if (document.contains(document.getElementsByClassName('ytp-ad-skip-button-modern ytp-button')[0])){console.log("WYTAS:Detected ad (action "+WYTAS_ver+"_1)");document.getElementsByClassName('ytp-ad-skip-button-modern ytp-button')[0].click();}
      if (document.contains(document.getElementsByClassName('ytp-ad-skip-button ytp-button')[0])){console.log("WYTAS:Detected ad (action "+WYTAS_ver+"_2)");document.getElementsByClassName('ytp-ad-skip-button ytp-button')[0].click();}
      if (document.contains(document.getElementsByClassName("ytp-ad-image")[0]) || document.contains(document.getElementsByClassName("ytp-ad-preview-image")[0])){console.log("WYTAS:Detected ad (action "+WYTAS_ver+"_3)");document.getElementsByClassName("html5-video-container")[0].children[0].currentTime=250;}
      document.getElementsByTagName("video")[0].playbackRate = pbs.value;
  });
});
const config = {childList:true,subtree:true};
observer.observe(document.body, config);



// Uncomment to enable speed changer feature
/*
var pbs = document.createElement("INPUT");
pbs.type = "number";
pbs.style = "background-color: rgba(0, 0, 0, 0.5); color: white; border: none; cursor: pointer; overflow: hidden; outline: none; width: 5ch; text-align: center; font-size: auto; -webkit-appearance: textfield; -moz-appearance: textfield;";
pbs.title = "Playback speed";

// Create the increment button
var incrementButton = document.createElement("BUTTON");
incrementButton.textContent = "+";
incrementButton.style = "background-color: rgba(0, 0, 0, 0.5); color: white; border: none; cursor: pointer; outline: none; font-size: 1.5em;";
incrementButton.addEventListener("click", function () {pbs.stepUp();var event = new Event("change", { bubbles: true, cancelable: true });pbs.dispatchEvent(event);});

// Create the decrement button
var decrementButton = document.createElement("BUTTON");
decrementButton.textContent = "-";
decrementButton.style = "background-color: rgba(0, 0, 0, 0.5); color: white; border: none; cursor: pointer; outline: none; font-size: 1.5em;";
decrementButton.addEventListener("click", function () {pbs.stepDown();var event = new Event("change", { bubbles: true, cancelable: true });pbs.dispatchEvent(event);});

// Create a container div to hold the input and buttons
var container = document.createElement("DIV");
container.style = "display: flex; align-items: center; margin:10px;";
container.appendChild(decrementButton);
container.appendChild(pbs);
container.appendChild(incrementButton);

pbs.step=0.1;
pbs.min=0;
pbs.value=1.0;
pbs.addEventListener("change",function(){if(pbs.value>0){document.getElementsByTagName("video")[0].playbackRate = pbs.value;}else{pbs.value=1;document.getElementsByTagName("video")[0].playbackRate = pbs.value;}});

document.getElementById('center').appendChild(container);
//*/
