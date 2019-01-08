# Stimulus components

## Diaalog component

```html
<div data-controller="dialog">
  <a href="#" data-action="click->dialog#open">Open</a>
  <div class="dialog-frame" data-target="dialog.container" style="display:none">
    <div class="container">
      <div class="title-bar float-right">
        <i class="far fa-times-circle" data-action="click->dialog#close"></i>
      </div>
      <h1>Sup</h1>

      <div class="action">
        Some action
      </div>
    </div>
  </div>
</div>
```
