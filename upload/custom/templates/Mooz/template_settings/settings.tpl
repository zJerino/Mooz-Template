<ul class="nav nav-pills" id="pills-tab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">Home & Portal</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="pills-styles-tab" data-toggle="pill" data-target="#pills-styles" type="button" role="tab" aria-controls="pills-styles" aria-selected="false">Styles</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="pills-contact-tab" data-toggle="pill" data-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">Others</a>
  </li>
</ul>
<hr />
<div class="tab-content mt-4" id="pills-tabContent">
  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
    <form action="" method=POST>
        <div class="form-group">
          <label for="nav-item-select">Central object of the navigation bar</label>
          <select class="form-control" id="nav-item-select" name='portal[nav_item]' {if !$mzv.portal}disabled{/if}>
            {foreach from=$navtop item=item key=key name=name}
              <option value="{$key}" {if ($key == $theme.portal.nav_item)}selected{/if}>{$item.title}</option>
            {/foreach}
          </select>
        </div>

        {if ($mzv.portal)}
          <div class="form-group">
              <label for="portal-description">Portal description text</label>
              <textarea name="portal[text]" id="portal-description"></textarea>
          </div>
        {else}
          <div class="form-group">
              <label for="inputHomeCustomContent">{$HOME_CUSTOM_CONTENT}</label>
              <textarea name="home_custom_content" id="inputHomeCustomContent"></textarea>
          </div>
        {/if}


        <div class="form-group">
            <input type="hidden" name="token" value="{$TOKEN}">
            <input type="submit" class="btn btn-primary" value="{$SUBMIT}">
        </div>
    </form>
  </div>
  <div class="tab-pane fade" id="pills-styles" role="tabpanel" aria-labelledby="pills-styles-tab">
    <form action="" method="post">
        <h5>Colors</h5>

        <div class="form-group">
          <label for="nav-item-select">Gradient primary color</label>
          <select class="form-control" id="gradient-select" name='gradient' aria-describedby="gradient-select-help">
            <option value="1" {if ($theme.gradient == 1)}selected{/if}>{$mzl.enabled}</option>
            <option value="0" {if ($theme.gradient != 1)}selected{/if}>{$mzl.disabled}</option>
          </select>
          <small id="gradient-select-help" class="form-text text-muted">This gradient is formed by joining the primary and secondary color.</small>          
        </div>

        {foreach from=$theme.colors item=item key=key name=name}
            <div class="form-group">
                <label for="theme-color-{$key}">{$key}</label>
                <input type="text" name="colors[{$key}]" class="form-control bscp" id="theme-color-{$key}" aria-describedby="theme-color-{$key}-help" value="{$item}">
                <small id="theme-color-{$key}-help" class="form-text text-muted">bg-{$key}</small>
            </div>
        {/foreach}
        
        <hr>
        
        <h5>Font</h5>

        <div class="form-group">
          <label for="theme-ff">Family</label>
          <input type="text" name="ff" class="form-control" id="theme-ff" value="{$theme.ff|escape:'htmlall'}">
        </div>

        <div class="form-group">
          <label for="theme-ff">Family Link</label>
          <input type="text" name="ffl" class="form-control" id="theme-ffl" value="{$theme.ffl}">
        </div>
        
        <div class="form-group">
          <label for="theme-fs">Size</label>
          <input type="text" name="fs" class="form-control" id="theme-fs" value="{$theme.fs}">
        </div>

        <div class="form-group">
            <input type="hidden" name="styles" value="1">
            <input type="hidden" name="token" value="{$TOKEN}">
            <input type="submit" class="btn btn-primary" value="{$SUBMIT}">
        </div>
    </form>
  </div>
  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
    <form action="" method="post">
      <h5>Others</h5>

      <div class="form-group">
        <label for="DefaultMode-select">{$mzl.dark_mode}</label>
        <select class="form-control" id="DefaultMode-select" name='defaultMode' aria-describedby="DefaultMode-select-help">
          <option value="1" {if ($theme.defaultMode == 1)}selected{/if}>{$mzl.enabled}</option>
          <option value="0" {if ($theme.defaultMode != 1)}selected{/if}>{$mzl.disabled}</option>
        </select>
        <small id="DefaultMode-select-help" class="form-text text-muted">This defines the default mode that will be displayed on your page by default is dark mode.</small>
      </div>

      <div class="form-group">
        <input type="hidden" name="token" value="{$TOKEN}">
        <input type="submit" class="btn btn-primary" value="{$SUBMIT}">
      </div>
    </form>
  </div>
</div>