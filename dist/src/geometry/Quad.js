import Drawable from '../rendering/gl/Drawable';
import { gl } from '../globals';
class Quad extends Drawable {
    // uvs: Float32Array;
    //center: vec4;
    constructor() {
        super();
    }
    create() {
        this.indices = new Uint32Array([0, 1, 2,
            0, 2, 3]);
        // this.normals = new Float32Array([0, 0, 1, 0,
        //                                 0, 0, 1, 0,
        //                                 0, 0, 1, 0,
        //                                 0, 0, 1, 0]);
        this.positions = new Float32Array([-1, -1, 0.999999, 1,
            1, -1, 0.999999, 1,
            1, 1, 0.999999, 1,
            -1, 1, 0.999999, 1]);
        this.generateIdx();
        this.generatePos();
        this.count = this.indices.length;
        gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.bufIdx);
        gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, this.indices, gl.STATIC_DRAW);
        // gl.bindBuffer(gl.ARRAY_BUFFER, this.bufNor);
        // gl.bufferData(gl.ARRAY_BUFFER, this.normals, gl.STATIC_DRAW);
        gl.bindBuffer(gl.ARRAY_BUFFER, this.bufPos);
        gl.bufferData(gl.ARRAY_BUFFER, this.positions, gl.STATIC_DRAW);
        console.log('Created quad');
    }
}
;
export default Quad;
//# sourceMappingURL=Quad.js.map