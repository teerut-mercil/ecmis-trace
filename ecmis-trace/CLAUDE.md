# ecmis-trace — กติกาโปรเจกต์

โปรเจกต์นี้ใช้เติมและอัปเดต E-CMIS Master Activity Template (Flow / Screen / LAW / Test Case / Traceability) ทีละ Activity จากเล่มเอกสารและ source code

## แหล่งข้อมูลและ Output

- `input/docs/` = เล่มเอกสาร เป็น **แหล่งความจริงหลัก**
- `input/code/` = source code (หรือไฟล์ชี้ path ไป repo) ใช้ **ยืนยันและเติมข้อมูลชั้นหน้าจอ** เท่านั้น ได้แก่ Page Code, ปุ่ม, สถานะ, validation, notification — ไม่ใช่แหล่งหลัก
- prototype ใน `input/code/` เป็นแบบอ่านอย่างเดียว **ยกเว้น** ขั้น 6 ที่เพิ่มไฟล์ Playwright test ตาม user flow ได้ (ไฟล์ test/config test เท่านั้น ห้ามแก้โค้ดหน้าจอ) หลังผู้ใช้ยืนยันในจุดตรวจ 3
- `template/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx` = template ต้นฉบับ **ห้ามแก้**
- `work/docs/` = เล่มที่แปลงเป็น Markdown ด้วย **markitdown** (สคริปต์ `scripts/convert_docs.py` ในโฟลเดอร์ skill) — PDF มีเลขหน้า, PPTX มีเลขสไลด์, DOCX และอื่น ๆ อ้างอิงด้วยหัวข้อ
- `work/extract/` = ข้อมูลที่สกัดแยกราย Activity (extract / verify / plan)
- `work/extract/_parts/` = ไฟล์ส่วนย่อยชั่วคราวของ sub-agent (เมื่อผู้ใช้เลือกทำพร้อมกัน — ดู `references/subagents.md` ในโฟลเดอร์ skill) ตัวหลักรวมเข้าไฟล์ของ Activity แล้วลบทิ้ง ไม่ใช่ที่มาของข้อมูล
- `work/graph/` = แผนที่โค้ด (graphify) ของ prototype ใช้ช่วยหาโค้ดในขั้น 3 และ 6 — สร้างที่นี่เท่านั้น ห้ามสร้าง `graphify-out/` ใน repo prototype
- ทุกขั้นทำผ่าน skill `/ecmis <เลข Activity>` (ติดตั้งที่ `.claude/skills/ecmis/` ในโปรเจกต์ หรือ `~/.claude/skills/ecmis/` แบบ global)
- Output มีไฟล์เดียวคือ `output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx` **ห้ามสร้างไฟล์ output อื่น** (Playwright test และ screenshot ของขั้น 6 อยู่ใน repo prototype ไม่นับเป็น output)
- `output/backup/` = ไฟล์สำรองก่อนแก้ทุกครั้ง (ไม่นับเป็น output)

## กติกาข้อมูล

1. **ห้ามเดา** ทุกช่องที่เติมต้องมีที่มาในคอลัมน์ `Source Ref / Page` (รูปแบบ: `ชื่อเล่ม น.xx` สำหรับ PDF, `ชื่อเล่ม สไลด์ xx` สำหรับ PPTX, `ชื่อเล่ม §ชื่อหัวข้อ` สำหรับ DOCX และไฟล์ที่ไม่มีเลขหน้า, `path/ไฟล์:บรรทัด` สำหรับโค้ด — ข้อมูลที่ถอดจากภาพให้ต่อท้ายด้วย `[อ่านจากภาพ]`) — ดูข้อ "ที่มาของแท็บที่ไม่มีคอลัมน์ Source Ref" ด้านล่าง
2. **หาข้อมูลไม่เจอ** → เว้นว่าง และเปิดรายการใน `10_Open_Issue` ระบุ Activity, แท็บ/ช่องที่ขาด และคำถามที่ต้องให้ผู้รู้ตอบ
3. **เล่มกับโค้ดไม่ตรงกัน** → ใช้ค่าจากเล่ม และเปิด Open Issue ระบุทั้งสองค่าพร้อมที่มา
4. **ข้อมูลร่างเดิม** (สถานะ "Draft - รอเทียบเล่ม" หรือ "Draft / รอเทียบเล่ม") ให้เทียบกับเล่ม:
   - ตรง → คงไว้และใส่ที่มา
   - ไม่ตรง → แก้ตามเล่ม
   - ไม่พบในเล่ม → คงไว้และเปิด Open Issue
5. **ค่าในช่อง dropdown ต้องมาจากแท็บ `99_Lists` เท่านั้น** — ถ้าช่องนั้นมี dropdown ที่ template กำหนดรายการไว้ในตัวช่องเอง (inline list เช่น Scenario Type, Screen Type, Test Result) ให้ใช้ได้เฉพาะค่าในรายการของช่องนั้น ห้ามพิมพ์ค่านอกรายการ
6. **รหัสตาม pattern เดิมและห้ามซ้ำ**: `FLOW-A05-001`, `SCR-A05-001-01`, `TR-A05-001`, `TC-A05-001`, `DOC-001`, `TD-001`, `ISS-001`, `CHG-001` (A05 = Activity 5 เติมศูนย์ให้ครบ 2 หลัก)
7. **Test Case ต้องครอบคลุม** Happy Path, Negative และ Return/Rework ตาม Decision ของแต่ละ Step
8. **ทำทีละ Activity** และหยุดสรุปผลให้ตรวจก่อนไป Activity ถัดไป

## กติกาการอัปเดตไฟล์ output

- ถ้ายังไม่มีไฟล์ output ให้คัดลอกจาก template ถ้ามีแล้วให้ **อัปเดตไฟล์เดิมเสมอ**
- ก่อนแก้ทุกครั้ง สำรองไฟล์ไป `output/backup/` ใส่วันเวลาในชื่อไฟล์ เช่น `ECMIS_Master_Activity_Template_FlowScreenTrace_20260921-1530.xlsx`
- **ห้ามแตะ** แถวที่สถานะ "ยืนยันแล้ว" และคอลัมน์ `Actual Result`, `Test Result`, `Step Result`, `Defect ID`
- จับคู่แถวเดิมกับข้อมูลใหม่ **ด้วยรหัส ไม่ใช่ลำดับแถว**
- รหัสเดิมห้ามเปลี่ยนเลข รายการใหม่รันเลขต่อจากเลขสูงสุด รหัสที่เคยลบ (ดูจาก `18_Change_Log`) ห้ามนำกลับมาใช้
- ค่าไม่ตรงกับฉบับใหม่ → แก้เป็นค่าใหม่ และบันทึกค่าเดิมใน `18_Change_Log`
- รายการที่ไม่พบในฉบับใหม่ → ลบแถว พร้อมลบแถวที่อ้างถึงในแท็บอื่นให้ครบ และบันทึกข้อมูลทั้งแถวใน `18_Change_Log`
  - ยกเว้นแถว "ยืนยันแล้ว" หรือมีผลทดสอบ/Defect แล้ว → **ไม่ลบ** ให้เปิด Open Issue แทน
- ต้นรอบล้างไฮไลต์ของรอบก่อน ระหว่างรอบไฮไลต์ช่องที่แก้ด้วย **สีเหลืองอ่อน** (`FFF2CC`) และแถวที่เพิ่มใหม่ด้วย **สีเขียวอ่อน** (`E2EFDA`)
- **ก่อนเขียนไฟล์ ต้องสรุปรายการเพิ่ม/แก้/ลบแยกตามแท็บให้ผู้ใช้ยืนยันก่อนทุกครั้ง**

## ข้อสังเกตเกี่ยวกับโครงสร้าง template (ใช้ประกอบทุกขั้น)

### ตำแหน่งตาราง
- ทุกแท็บ: แถว 1 = ชื่อแท็บ, แถว 2 = คำอธิบาย, แถว 5 = หัวคอลัมน์, ข้อมูลเริ่มแถว 6 ถึงแถวสุดท้ายของกรอบตาราง (เช่น `04_MainFlow` ถึงแถว 205, `11_Screen_Sequence` ถึงแถว 505)
- เพิ่มข้อมูลในแถวว่างภายในกรอบตาราง ใช้ style ของแถวนั้น (ห้ามเปลี่ยนสี/เส้นขอบ ยกเว้นไฮไลต์ตามกติกา)
- แท็บ `11_Process_Step_Detail` กับ `11_Screen_Sequence` ใช้เลข 11 เหมือนกัน — อ้างด้วยชื่อแท็บเต็มเสมอ

### คอลัมน์สถานะ (ใช้ตัดสินว่าแถวไหน "ยืนยันแล้ว")
| แท็บ | คอลัมน์สถานะ |
|---|---|
| 01_ภาพรวม_Activity | สถานะยืนยัน |
| 03_ใครทำอะไร | สถานะยืนยัน |
| 04_MainFlow | สถานะยืนยัน |
| 05_SupportingFlow | สถานะยืนยัน |
| 06_จุดเชื่อม | สถานะยืนยัน |
| 07_Gap_Feature / 08_Feature_Catalog | สถานะ |
| 09_Permission | สถานะยืนยัน |
| 11_Process_Step_Detail | Confirmation Status |
| 16_Traceability | Confirmation |
| 11_Screen_Sequence | Screen Type = "Draft / รอเทียบเล่ม" หมายถึงยังเป็นร่าง |

แท็บที่ไม่มีคอลัมน์สถานะ (12, 13, 14, 15, 17) ให้ถือสถานะตามแถว Flow/Step ที่อ้างถึง

### ที่มาของแท็บที่ไม่มีคอลัมน์ Source Ref
- แท็บที่มีคอลัมน์ที่มา: `11_Process_Step_Detail`, `12_Document_Matrix`, `13_LAW_Transition`, `14_TestCase_Master`, `16_Traceability` (`Source Ref / Page`) และ `17_Test_Data` (`Source / Rule`) → ใส่ที่มาในคอลัมน์นั้น
- แท็บที่ไม่มีคอลัมน์ที่มา (00–09, 11_Screen_Sequence, 15_Test_Steps) → ที่มาของทุกช่องที่เติม/แก้ ต้องอยู่ในคอลัมน์ `ที่มา` ของ `18_Change_Log` (บันทึกทั้งประเภท เพิ่ม และ แก้) **ห้ามเพิ่มคอลัมน์ใหม่ใน template**
- `10_Open_Issue` ใช้คอลัมน์ `Ref / Meeting` เป็นที่มา

### สูตรและ hyperlink (ต้องคงไว้และชี้แถวให้ถูก)
- `00_Activity_Index`: `Open Issue` (COUNTIFS จาก 10_Open_Issue), `Completion %`
- `04_MainFlow`: `Screen Count` = COUNTIF(`11_Screen_Sequence`!D, Flow ID)
- `16_Traceability`: `Test Case Count`, `Coverage`, `Gap / Missing`
- Hyperlink เป็นสูตร `=HYPERLINK("#'ชื่อแท็บ'!A{แถว}","ข้อความ")` อยู่ในคอลัมน์ `Link to Flow` / `Link to Screen Sequence` (แท็บ 11_Process_Step_Detail, 14, 15, 16) และ `Flow Link` (11_Screen_Sequence)
- **แถวใน hyperlink ต้องเป็นแถวที่รหัสปลายทางอยู่จริง** (ค้นหาจาก Flow ID / Screen Seq ID) ไม่ใช่เลขแถวเดียวกันกับแถวต้นทาง — ทุกครั้งที่เพิ่ม/ลบ/ย้ายแถว ต้องคำนวณ hyperlink ใหม่ทั้งแท็บ
- ช่วงอ้างอิงในสูตรเป็นช่วงคงที่ (เช่น `$A$6:$A$405`) — การลบแถวให้ใช้วิธี **เลื่อนข้อมูลแถวล่างขึ้นแทนแถวที่ลบภายในกรอบตาราง** แล้วเขียนสูตรของแต่ละแถวใหม่ตาม pattern เดิม ห้ามใช้การลบแถวของ Excel/openpyxl (`delete_rows`) เพราะทำให้กรอบตาราง dropdown และช่วงสูตรเพี้ยน
- ค่า cache ของสูตร HYPERLINK ใน template เป็นค่า error ที่ตัวสร้างไฟล์ทิ้งไว้ ("HYPERLINK is not implemented") Excel จะคำนวณใหม่ตอนเปิดไฟล์ — การตรวจสูตรให้ตรวจจากตัวสูตร ไม่ใช่ค่า cache

### เครื่องมือ
- อ่านโค้ดด้วยแผนที่โค้ด graphify (`references/code-graph.md` ในโฟลเดอร์ skill) เป็นตัวช่วยหาตำแหน่ง — ที่มาที่บันทึกต้องเป็น `path/ไฟล์:บรรทัด` จากการเปิดไฟล์จริง ถ้าไม่มี graphify ให้อ่านโค้ดแบบปกติ
- แปลงเล่มเอกสารด้วย markitdown ผ่าน `convert_docs.py` เท่านั้น — หน้าที่สคริปต์ติดป้าย "ต้องอ่านจากภาพ" ให้ Claude อ่านจากไฟล์ต้นฉบับแทน
- แก้ Excel ด้วย Python `openpyxl` (โหลดแบบปกติ ไม่ใช้ `data_only=True` เพื่อไม่ให้สูตรหาย)
- สคริปต์ชั่วคราวเก็บนอกโปรเจกต์ (scratchpad) ห้ามทิ้งไฟล์ .xlsx อื่นไว้ใน `output/`
