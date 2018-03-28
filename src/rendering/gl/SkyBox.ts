import Texture from './Texture';
import {gl} from '../../globals';
import ShaderProgram, {Shader} from './ShaderProgram';
import Drawable from './Drawable';
import Quad from '../../geometry/Quad';
import {vec3, vec4, mat4} from 'gl-matrix';

class SkyBox extends ShaderProgram{
    static screenQuad: Quad = undefined;
    unifFrame: WebGLUniformLocation;
    name: string;

    constructor(fragProg: Shader, tag: string = "default"){
        super([new Shader(gl.VERTEX_SHADER, require('../../shaders/skyBox-vert.glsl')),
            fragProg]);
        this.unifFrame = gl.getUniformLocation(this.prog, "u_frame");
        this.use();
        this.name = tag;
        gl.uniform1i(this.unifFrame, 0);
        if(SkyBox.screenQuad === undefined){
            SkyBox.screenQuad = new Quad;
            SkyBox.screenQuad.create();

        }
    }

    draw(){
        super.draw(SkyBox.screenQuad);
    }
    getName() : string {return this.name;}
}

export default SkyBox;