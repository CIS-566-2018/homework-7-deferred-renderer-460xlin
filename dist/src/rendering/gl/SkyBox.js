import { gl } from '../../globals';
import ShaderProgram, { Shader } from './ShaderProgram';
import Quad from '../../geometry/Quad';
class SkyBox extends ShaderProgram {
    constructor(fragProg, tag = "default") {
        super([new Shader(gl.VERTEX_SHADER, require('../../shaders/skyBox-vert.glsl')),
            fragProg]);
        this.unifFrame = gl.getUniformLocation(this.prog, "u_frame");
        this.use();
        this.name = tag;
        gl.uniform1i(this.unifFrame, 0);
        if (SkyBox.screenQuad === undefined) {
            SkyBox.screenQuad = new Quad;
            SkyBox.screenQuad.create();
        }
    }
    draw() {
        super.draw(SkyBox.screenQuad);
    }
    getName() { return this.name; }
}
SkyBox.screenQuad = undefined;
export default SkyBox;
//# sourceMappingURL=SkyBox.js.map