import './main.css';
import { Main } from './Main.elm';
import { init } from './CustomSearch/element-port.js';

const app = Main.embed(document.getElementById('root'));
init(app);
