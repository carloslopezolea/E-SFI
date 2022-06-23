# E-SFI
Two-dimensional, two-node, shear-flexure interaction element.  
This element shall be used in Domain defined with ``-ndm 2 -ndf 3``

**Developed and implemented by:**    
- [C. N. López](mailto:carlos.lopez.o@ug.uchile.cl), University of Chile, Santiago<br/>
- L. M. Massone, University of Chile, Santiago<br/>
- K. Kolozvari, CSU Fullerton<br/>

## Description

The Efficient Shear-Flexure Interaction (E-SFI) element was developed based on the [SFI-MVLEM](https://opensees.berkeley.edu/wiki/index.php/SFI_MVLEM_-_Cyclic_Shear-Flexure_Interaction_Model_for_RC_Walls) formulation. The E-SFI element incorporates the shear-flexure interaction phenomenon by replacing the **m** number of uniaxial fibers of the [MVLEM](https://opensees.berkeley.edu/wiki/index.php/MVLEM_-_Multiple-Vertical-Line-Element-Model_for_RC_Walls), by two-dimensional RC panel elements subjected to membrane actions ([FSAM](https://opensees.berkeley.edu/wiki/index.php/FSAM_-_2D_RC_Panel_Constitutive_Behavior)). As illustrated in Fig. 1(a), an E-SFI element is described by six degrees of freedom, and therefore no additional degrees of freedom are incorporated into the original MVLEM formulation, as in the SFI-MVLEM. The curvature of an E-SFI element is assumed to be uniform, and the resultant rotation is concentrated at height **ch**. The kinematic assumption of plane sections remain plane, as well as the assumption of constant shear strain along the element length, are considered for computing the axial and shear strains for each panel over the entire section. To complete the strain field of a panel element, a calibrated expression for the horizontal normal strain $(\varepsilon_{x})$ is implemented to obtain accurate predictions from squat to slender RC walls. As shown in Fig. 1(b), a structural wall is modeled as a stack of **n** E-SFI elements, which are placed one upon the other, resulting in a total number of $N =3⋅(n +1)$ degrees of freedom. 

![Model_Formulation](/images/ESFI_ELEMENT.jpg)<br/>
**Figure 1: E-SFI element: (a) Element idealization; (b) Wall model.**

### E-SFI Input TCL
```bash
element E-SFI eleTag iNode jNode m  c -thick {Thicknesses} -width {Widths} -mat {Material_tags} <-Density Dens>

```

| Parameter | Description |
|:----------|:------------|
| eleTag | unique element tag|
| iNode jNode | tags of element nodes defined in upward direction|
| m | number of element macro-fibers|
| c | location of center of rotation with from the iNode, c = 0.4 (recommended)|
| {Thicknesses} | array of m macro-fiber thicknesses|
| {Widths} | array of m macro-fiber widths |
| {Material_tags}| array of m macro-fiber nDMaterial [FSAM](https://opensees.berkeley.edu/wiki/index.php/FSAM_-_2D_RC_Panel_Constitutive_Behavior) tags|
| Dens | element density (optional, default = 0.00)|

### Recorders

The following recorders are available with the E-SFI element.

| Recorder | Description |
|:----------|:------------|
| globalForce | element global forces|
| Curvature | element curvature|
| ShearDef | element shear deformation|
| RCPanel $fibTag $Response | returns RC panel (macro-fiber) $Response for a $fibTag-th panel (1 ≤ fibTag ≤ m). For available $Response-s refer to nDMaterial [FSAM](https://opensees.berkeley.edu/wiki/index.php/FSAM_-_2D_RC_Panel_Constitutive_Behavior) |

## Example
Input files (.tcl) used to build the wall model and perform displacement-controlled analysis can be found in [RC Wall Example](/examples/Example_1). To run the analysis use the file ``Run_Pushover.tcl``.


## References
- Massone, L. M., López, C. N., & Kolozvari, K. (2021). Formulation of an efficient shear-flexure interaction model for planar reinforced concrete walls. Engineering Structures, 243, 112680. [link](https://www.sciencedirect.com/science/article/abs/pii/S0141029621008300)  
- López, C. N., Massone, L. M., & Kolozvari, K. (2022). Validation of an efficient shear-flexure interaction model for planar reinforced concrete walls. Engineering Structures, 252, 113590. [link](https://www.sciencedirect.com/science/article/abs/pii/S0141029621016837)
- López C. N. Efficient shear-flexure interaction model for nonlinear analysis of reinforced concrete structural walls. MS Dissertation. Santiago, Chile: University of
Chile; 2021. [link](https://repositorio.uchile.cl/handle/2250/180296)

