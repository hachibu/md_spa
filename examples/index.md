```css
body {
  align-items: center;
  background: white;
  display: flex;
  font-family: sans-serif;
  height: 100vh;
  justify-content: center;
}
```

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/16.3.1/umd/react.production.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react-dom/16.3.1/umd/react-dom.production.min.js"></script>

<div id="root"></div>
```

```javascript
ReactDOM.render(
  React.createElement('h1', null, 'Hello, world!'),
  document.getElementById('root')
);
```
