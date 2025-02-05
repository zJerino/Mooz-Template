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

      u.classList.add('d-flex');
      u.classList.add('flex-wrap');

      u.innerHTML = e.innerHTML;

      let h = {};
      
      if (u != undefined && u != ' ') {
        h['.popover-body'] = u;
      }
      
      if (ppTitle != undefined && ppTitle != ' ') {
        h['.popover-header'] = ppTitle;
      }
      PopoverI.setContent(h);
    }
  })

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
