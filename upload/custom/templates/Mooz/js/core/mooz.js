console.log('Bienvenido a la consola de Mooz');

document.addEventListener("DOMContentLoaded", () => {
  /**
   * Bs Tooltip
   */
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

  /**
   * Bs Popover
   */
  const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
  const popoverList = [...popoverTriggerList].map(popoverTriggerEl => {
    let popoverTemplate = '"<div class="popover" role="tooltip"><div class="popover-arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>"';

    let ppbclasses = popoverTriggerEl.hasAttribute('data-body-class') ? popoverTriggerEl.getAttribute('data-body-class') : '';
    
    if (ppbclasses != '') {
        popoverTemplate = '"<div class="popover" role="tooltip"><div class="popover-arrow"></div><h3 class="popover-header"></h3><div class="popover-body custom-popover '+ppbclasses+'"></div></div>"';
    }


    let PopoverI =  new bootstrap.Popover(popoverTriggerEl, {
      sanitize: false,
      template: popoverTemplate
    });
    
    if (popoverTriggerEl.hasAttribute('data-element') && document.querySelector(popoverTriggerEl.getAttribute('data-element')) != undefined)  {
      let e = document.querySelector(popoverTriggerEl.getAttribute('data-element'));

      let ppTitle= popoverTriggerEl.hasAttribute('data-bs-title') ? popoverTriggerEl.getAttribute('data-bs-title') : undefined;

      let u = document.createElement('div');

      e.classList.add('d-flex');
      e.classList.add('flex-wrap');


      let h = {};
      
      if (e != undefined && e != ' ') {
        h['.popover-body'] = e;
      }
      
      if (ppTitle != undefined && ppTitle != ' ') {
        h['.popover-header'] = ppTitle;
      }
      PopoverI.setContent(h);
      return PopoverI;
    }
  })

  window.jisdj3uj = popoverList;

  /**
   * Bs Toast
   */
  const toastContainer = $('#app-toast-container');

  window.toast = function(option) {
    let opts = {
      title: undefined,
      img: undefined,
      timeago: undefined,
      description: undefined,
      closeable: true,
      animation: true,
      autohide: true,
      delay: 5000,
      show: true,
      icon: undefined,
      customClass: [],
      ...option
    }

    if (opts.message != undefined) opts.description = opts.message;
    if (opts.content != undefined) opts.description = opts.content;

    let elToast = document.createElement('div');
    elToast.setAttribute('role', 'alert');
    elToast.setAttribute('aria-live', 'assertive');
    elToast.setAttribute('aria-atomic', 'true');
    elToast.classList.add('toast', ...opts.customClass);

    /**
     * Header
     */
    if (opts.title != undefined || opts.title != undefined || opts.timeago != undefined) {
      let elToastH = document.createElement('div');
      elToastH.classList.add('toast-header');

      /**
       * Imagen
       */
      if (opts.img != undefined) {
        let elToastHIMG = document.createElement('img');
        elToastHIMG.src = opts.img;
        elToastH.appendChild(elToastHIMG);
      }

      /**
       * Titulo
       */
      if (opts.title != undefined) {
        let elToastHTitle = document.createElement('strong');
        elToastHTitle.classList.add('me-auto');
        elToastHTitle.innerText = opts.title;
        elToastH.appendChild(elToastHTitle);
      }

      /**
       * Timeago
       */
      if (opts.timeago != undefined) {
        let elToastHTimeago = document.createElement('small');
        elToastHTimeago.innerText = opts.timeago;
        elToastH.appendChild(elToastHTimeago);
      }

      /**
       * Closeable
       */
      if (opts.closeable == true) {
        let elToastHClose = document.createElement('button');
        elToastHClose.classList.add('btn-close');
        elToastHClose.setAttribute('type', 'button');
        elToastHClose.setAttribute('aria-label', 'close');
        elToastHClose.dataset['bsDismiss'] = 'toast';
        elToastH.appendChild(elToastHClose);
      }

      elToast.appendChild(elToastH);

      
      /**
       * Body
       */
      if (opts.description != undefined) {
        let elToastB = document.createElement('div');
        elToastB.classList.add('toast-body');        
        elToastB.innerText = opts.description;
        elToast.appendChild(elToastB);
      }
    } else {
      let elToastBC = document.createElement('div');
      elToastBC.classList.add('d-flex');

      /**
       * Body
       */
      if (opts.description != undefined) {
        let elToastB = document.createElement('div');
        elToastB.classList.add('toast-body', 'd-flex', 'align-items-center');
        /**
         * Icon
         */
        if (opts.icon != undefined) {
          let elToastBIcon = document.createElement('i');
          elToastBIcon.classList.add('bi', 'bi-' + opts.icon, 'me-1', 'fs-4');
          elToastB.appendChild(elToastBIcon);
        }

        elToastB.innerHTML += opts.description;
        elToastBC.appendChild(elToastB);
      }

      /**
       * Closeable
       */
      if (opts.closeable == true) {
        let elToastBClose = document.createElement('button');
        elToastBClose.classList.add('btn-close', 'me-2', 'm-auto');
        elToastBClose.setAttribute('type', 'button');
        elToastBClose.setAttribute('aria-label', 'close');
        elToastBClose.dataset['bsDismiss'] = 'toast';
        elToastBC.appendChild(elToastBClose);
      }
      elToast.classList.add('align-items-center');
      elToast.append(elToastBC);
    }

    toastContainer.append(elToast);

    let mzbsToast = bootstrap.Toast.getOrCreateInstance(elToast);

    /**
     * Config
     */
    mzbsToast._config.animation = opts.animation;
    mzbsToast._config.autohide = opts.autohide;
    mzbsToast._config.delay = opts.delay;

    if (opts.show == true) mzbsToast.show();

    return {
      element: elToast,
      config: opts,
      bsToast: mzbsToast
    };
  }

  /**
   * Mz Links
   */
  const MzLink = document.querySelectorAll('[data-href]');
  const LinksList = [...MzLink].map(e => e.addEventListener('click', () => {
    window.location.href = e.getAttribute('data-href');
  }));

  /**
   * Mz Submit
   */
  const MzSubmit = document.querySelectorAll('[data-form-submit]');
  const MzSubmitList = [...MzSubmit].map(e => e.addEventListener('click', () => {
    let formID = e.getAttribute('data-form-submit');
    let formElement = document.querySelector(formID);

    if (formElement != undefined && formElement.tagName != 'FORM') return;

    
    formElement.submit();
  }));

  /**
   * Mooz navbar
   */
  let header = document.querySelector("#app-base > #app-header");
  let headerSize = header.clientHeight;
  header.style.minHeight = headerSize + 5 + "px";

  let navbar = document.querySelector(
    "#app-base > #app-header > #app-header-navbar"
  );
  let navbarContainer = document.querySelector(
    "#app-base > #app-header > #app-header-navbar > div"
  );

  let navbarEffect = false;
  navbar.style.transition = ".40s";

  document.addEventListener("scroll", () => {
    if (window.scrollY > headerSize * 1.15) {
      if (!navbar.classList.contains("fixed-bar") && !navbarEffect) {
        navbarEffect = true;

        navbar.style.top = "-" + (navbar.clientHeight + 20) + "px";          

        setTimeout(() => {
          navbar.classList.add("fixed-bar");
        }, 250);

        setTimeout(() => {
          navbar.style.top = "0";
          
          if (navbarContainer &&navbarContainer.classList.contains("container-fluid")) {
            navbarContainer.classList.add("container");
            navbarContainer.classList.remove("container-fluid");
          }

          navbarEffect = false;
        }, 500);
      }
    } else {
      if (navbar.classList.contains("fixed-bar")) {
        navbarEffect = true;

        navbar.style.top = "-" + (navbar.clientHeight + 20) + "px";

        setTimeout(() => {
          navbar.style.opacity = 0;

          if (
            navbarContainer &&
            navbarContainer.classList.contains("container")
          ) {
            navbarContainer.classList.add("container-fluid");
            navbarContainer.classList.remove("container");
          }
        }, 250);

        setTimeout(() => {
          navbar.classList.remove("fixed-bar");
          navbar.style.top = "0";
          setInterval(() => {
            navbar.style.opacity = 1;
            navbarEffect = false;
          }, 250);
        }, 500);
      }
    }
  });


});