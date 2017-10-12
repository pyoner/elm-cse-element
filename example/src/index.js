import './main.css';
import { Main } from './Main.elm';
import { init } from '../../src/CustomSearch/element-port.js';

const app = Main.embed(document.getElementById('root'));
init(app);
