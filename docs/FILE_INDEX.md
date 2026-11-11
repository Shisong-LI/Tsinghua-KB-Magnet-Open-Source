# Hardware file index

The release contains **45 original hardware files**, totaling **10,100,451 bytes**. Their names and bytes are preserved. English descriptions below are navigation aids; the original filenames remain the reference identifiers.

| Format | Count | Purpose |
| --- | ---: | --- |
| SLDASM | 1 | Native SolidWorks assembly |
| SLDPRT | 20 | 13 assembly-folder parts and 7 drawing-associated native parts |
| SLDDRW | 7 | Native SolidWorks drawing sources |
| STEP | 8 | Individual component exchange models |
| PDF | 9 | Engineering drawing sheets |

## Read before using the models

The PDF for `A5_SmCo` explicitly specifies **sintered NdFeB M50**, despite its filename. The upper and lower fixture PDFs identify **V2.0**, while their assembly-folder native filenames identify **V1.0**. The five principal yoke PDFs specify **DT4**. See the [manufacturing guide](MANUFACTURING.md) for these discrepancies, sheet quantities, and process notes.

Native models in the two folders are retained separately. Several pairs differ in content. The manifest proves file identity and provenance; it does not prove that a PDF, STEP, and native model describe identical geometry. See the [CAD guide](CAD_GUIDE.md).

The complete machine-readable records, including original relative paths, sizes, formats, roles, and SHA-256 digests, are available as [JSON](../metadata/file-manifest.json) and [CSV](../metadata/file-manifest.csv).

## Assembly and neighboring native parts

These 14 files reproduce the original assembly folder: one assembly and 13 part files. Keep them together when resolving assembly references.

| Original file | English description | Format | Bytes |
| --- | --- | --- | ---: |
| [01.THUKB-CY-01-00 M磁组.SLDASM](../hardware/solidworks/01.THUKB-CY-01-00%20M%E7%A3%81%E7%BB%84.SLDASM) | Magnet assembly | SLDASM | 703,015 |
| [A5_CoverV1.0.SLDPRT](../hardware/solidworks/A5_CoverV1.0.SLDPRT) | Cover yoke | SLDPRT | 225,441 |
| [A5_InnerLV1.0.SLDPRT](../hardware/solidworks/A5_InnerLV1.0.SLDPRT) | Inner yoke L | SLDPRT | 119,333 |
| [A5_InnerSV1.0.SLDPRT](../hardware/solidworks/A5_InnerSV1.0.SLDPRT) | Inner yoke S | SLDPRT | 121,599 |
| [A5_OuterLV1.0.SLDPRT](../hardware/solidworks/A5_OuterLV1.0.SLDPRT) | Outer yoke L | SLDPRT | 333,583 |
| [A5_OuterSV1.0.SLDPRT](../hardware/solidworks/A5_OuterSV1.0.SLDPRT) | Outer yoke S | SLDPRT | 324,567 |
| [A5_SmCoV1.0.SLDPRT](../hardware/solidworks/A5_SmCoV1.0.SLDPRT) | Permanent-magnet ring (filename; PDF specifies NdFeB M50) | SLDPRT | 83,067 |
| [GB／T77-2000内六角平端紧定螺钉M6×10.SLDPRT](../hardware/solidworks/GB%EF%BC%8FT77-2000%E5%86%85%E5%85%AD%E8%A7%92%E5%B9%B3%E7%AB%AF%E7%B4%A7%E5%AE%9A%E8%9E%BA%E9%92%89M6%C3%9710.SLDPRT) | Hexagon socket flat-point set screw M6 x 10 (filename designation) | SLDPRT | 113,558 |
| [上部磁体固定件V1.0.SLDPRT](../hardware/solidworks/%E4%B8%8A%E9%83%A8%E7%A3%81%E4%BD%93%E5%9B%BA%E5%AE%9A%E4%BB%B6V1.0.SLDPRT) | Upper magnet fixture | SLDPRT | 139,983 |
| [下部磁体固定件V1.0.SLDPRT](../hardware/solidworks/%E4%B8%8B%E9%83%A8%E7%A3%81%E4%BD%93%E5%9B%BA%E5%AE%9A%E4%BB%B6V1.0.SLDPRT) | Lower magnet fixture | SLDPRT | 136,507 |
| [内六角圆柱头螺钉M3×8.SLDPRT](../hardware/solidworks/%E5%86%85%E5%85%AD%E8%A7%92%E5%9C%86%E6%9F%B1%E5%A4%B4%E8%9E%BA%E9%92%89M3%C3%978.SLDPRT) | Socket-head cap screw M3 x 8 | SLDPRT | 115,791 |
| [内六角圆柱头螺钉M6×30.SLDPRT](../hardware/solidworks/%E5%86%85%E5%85%AD%E8%A7%92%E5%9C%86%E6%9F%B1%E5%A4%B4%E8%9E%BA%E9%92%89M6%C3%9730.SLDPRT) | Socket-head cap screw M6 x 30 | SLDPRT | 115,882 |
| [内六角圆柱头螺钉M6×80.SLDPRT](../hardware/solidworks/%E5%86%85%E5%85%AD%E8%A7%92%E5%9C%86%E6%9F%B1%E5%A4%B4%E8%9E%BA%E9%92%89M6%C3%9780.SLDPRT) | Socket-head cap screw M6 x 80 | SLDPRT | 102,442 |
| [内磁轭卡件V1.0.SLDPRT](../hardware/solidworks/%E5%86%85%E7%A3%81%E8%BD%AD%E5%8D%A1%E4%BB%B6V1.0.SLDPRT) | Inner-yoke clamp | SLDPRT | 250,544 |

## Drawing-associated source set

These 31 files reproduce the original drawing folder. The table preserves its mixed formats and original naming.

| Original file | English description | Format | Bytes |
| --- | --- | --- | ---: |
| [A5_Cover - 图纸.pdf](../hardware/drawings/A5_Cover%20-%20%E5%9B%BE%E7%BA%B8.pdf) | Cover yoke | PDF | 136,703 |
| [A5_Cover.SLDDRW](../hardware/drawings/A5_Cover.SLDDRW) | Cover yoke | SLDDRW | 441,877 |
| [A5_Cover.SLDPRT](../hardware/drawings/A5_Cover.SLDPRT) | Cover yoke | SLDPRT | 211,247 |
| [A5_Cover.STEP](../hardware/drawings/A5_Cover.STEP) | Cover yoke | STEP | 250,598 |
| [A5_InnerL - 图纸.pdf](../hardware/drawings/A5_InnerL%20-%20%E5%9B%BE%E7%BA%B8.pdf) | Inner yoke L | PDF | 63,132 |
| [A5_InnerL.SLDDRW](../hardware/drawings/A5_InnerL.SLDDRW) | Inner yoke L | SLDDRW | 182,580 |
| [A5_InnerL.SLDPRT](../hardware/drawings/A5_InnerL.SLDPRT) | Inner yoke L | SLDPRT | 103,981 |
| [A5_InnerL.STEP](../hardware/drawings/A5_InnerL.STEP) | Inner yoke L | STEP | 31,354 |
| [A5_InnerS - 图纸.pdf](../hardware/drawings/A5_InnerS%20-%20%E5%9B%BE%E7%BA%B8.pdf) | Inner yoke S | PDF | 63,033 |
| [A5_InnerS.SLDDRW](../hardware/drawings/A5_InnerS.SLDDRW) | Inner yoke S | SLDDRW | 177,019 |
| [A5_InnerS.SLDPRT](../hardware/drawings/A5_InnerS.SLDPRT) | Inner yoke S | SLDPRT | 106,359 |
| [A5_InnerS.STEP](../hardware/drawings/A5_InnerS.STEP) | Inner yoke S | STEP | 31,349 |
| [A5_OuterL-图纸.pdf](../hardware/drawings/A5_OuterL-%E5%9B%BE%E7%BA%B8.pdf) | Outer yoke L | PDF | 77,234 |
| [A5_OuterLV1.0.SLDDRW](../hardware/drawings/A5_OuterLV1.0.SLDDRW) | Outer yoke L | SLDDRW | 710,778 |
| [A5_OuterLV1.0.SLDPRT](../hardware/drawings/A5_OuterLV1.0.SLDPRT) | Outer yoke L | SLDPRT | 333,583 |
| [A5_OuterLV1.0.STEP](../hardware/drawings/A5_OuterLV1.0.STEP) | Outer yoke L | STEP | 895,320 |
| [A5_OuterS-图纸.pdf](../hardware/drawings/A5_OuterS-%E5%9B%BE%E7%BA%B8.pdf) | Outer yoke S | PDF | 76,709 |
| [A5_OuterS.SLDDRW](../hardware/drawings/A5_OuterS.SLDDRW) | Outer yoke S | SLDDRW | 711,750 |
| [A5_OuterS.SLDPRT](../hardware/drawings/A5_OuterS.SLDPRT) | Outer yoke S | SLDPRT | 324,567 |
| [A5_OuterS.STEP](../hardware/drawings/A5_OuterS.STEP) | Outer yoke S | STEP | 888,370 |
| [A5_SmCo - 图纸.pdf](../hardware/drawings/A5_SmCo%20-%20%E5%9B%BE%E7%BA%B8.pdf) | Permanent-magnet ring (filename; PDF specifies NdFeB M50) | PDF | 58,136 |
| [A5_SmCo.SLDDRW](../hardware/drawings/A5_SmCo.SLDDRW) | Permanent-magnet ring (filename; PDF specifies NdFeB M50) | SLDDRW | 133,517 |
| [A5_SmCo.SLDPRT](../hardware/drawings/A5_SmCo.SLDPRT) | Permanent-magnet ring (filename; PDF specifies NdFeB M50) | SLDPRT | 68,413 |
| [上部磁体固定件.pdf](../hardware/drawings/%E4%B8%8A%E9%83%A8%E7%A3%81%E4%BD%93%E5%9B%BA%E5%AE%9A%E4%BB%B6.pdf) | Upper magnet fixture | PDF | 64,523 |
| [上部磁体固定件.STEP](../hardware/drawings/%E4%B8%8A%E9%83%A8%E7%A3%81%E4%BD%93%E5%9B%BA%E5%AE%9A%E4%BB%B6.STEP) | Upper magnet fixture | STEP | 112,016 |
| [下部磁体固定件.pdf](../hardware/drawings/%E4%B8%8B%E9%83%A8%E7%A3%81%E4%BD%93%E5%9B%BA%E5%AE%9A%E4%BB%B6.pdf) | Lower magnet fixture | PDF | 64,886 |
| [下部磁体固定件.STEP](../hardware/drawings/%E4%B8%8B%E9%83%A8%E7%A3%81%E4%BD%93%E5%9B%BA%E5%AE%9A%E4%BB%B6.STEP) | Lower magnet fixture | STEP | 111,997 |
| [内磁轭卡件 - 图纸1.pdf](../hardware/drawings/%E5%86%85%E7%A3%81%E8%BD%AD%E5%8D%A1%E4%BB%B6%20-%20%E5%9B%BE%E7%BA%B81.pdf) | Inner-yoke clamp | PDF | 74,212 |
| [内磁轭卡件.SLDDRW](../hardware/drawings/%E5%86%85%E7%A3%81%E8%BD%AD%E5%8D%A1%E4%BB%B6.SLDDRW) | Inner-yoke clamp | SLDDRW | 303,976 |
| [内磁轭卡件.SLDPRT](../hardware/drawings/%E5%86%85%E7%A3%81%E8%BD%AD%E5%8D%A1%E4%BB%B6.SLDPRT) | Inner-yoke clamp | SLDPRT | 204,754 |
| [内磁轭卡件.STEP](../hardware/drawings/%E5%86%85%E7%A3%81%E8%BD%AD%E5%8D%A1%E4%BB%B6.STEP) | Inner-yoke clamp | STEP | 201,166 |

## Coverage limits

The archive supplies no whole-assembly STEP, no `A5_SmCo` STEP, no standard-screw PDF drawings, and no native drawing sources for the upper/lower fixtures. The fixture native parts are present beside the assembly. No FEA model, raw magnetic scan, magnetization map, machining inspection report, or assembly-derived bill of materials is included.

A PDF sheet quantity is distinct from a file count. Standard screw quantities and the active assembly configuration must be established from a resolved SolidWorks assembly.
