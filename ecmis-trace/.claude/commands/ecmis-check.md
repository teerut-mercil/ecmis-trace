---
description: ตรวจความถูกต้องของไฟล์ output (coverage, ที่มา, รหัส/การอ้างอิง/hyperlink, สูตร, dropdown, แถวที่ห้ามแก้) และรายงานรายการที่ไม่ผ่าน
argument-hint: <เลข Activity เช่น 5 (ไม่ระบุ = ตรวจทั้งไฟล์)>
---

อ่าน `CLAUDE.md` ให้ครบก่อนเริ่ม และทำตามกติกาในนั้นตลอดงานนี้

Activity: **$ARGUMENTS** (ถ้าไม่ระบุ ให้ตรวจทุก Activity ในไฟล์)

## ขอบเขต
- **อ่านอย่างเดียว** ห้ามแก้ไฟล์ output — รายงานผลเท่านั้น
- ไฟล์ที่ตรวจ: `output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx` ถ้าไม่มีให้หยุดแจ้งผู้ใช้
- โหลดด้วย openpyxl แบบปกติ (ไม่ใช้ data_only) เพื่อตรวจตัวสูตร

## รายการตรวจ
1. **Coverage** — ทุก LAW Step (แถวใน `11_Process_Step_Detail` และ `16_Traceability` ที่มี LAW / Function No.) มี Test Case อย่างน้อย 1 รายการที่มีอยู่จริงใน `14_TestCase_Master` และแต่ละ Step ที่มี Decision มี Test Case ครอบคลุม Happy Path, Negative, Return/Rework
2. **ที่มา** — ทุกแถวที่มีข้อมูลในแท็บที่มีคอลัมน์ `Source Ref / Page` (หรือ `Source / Rule`) ต้องมีค่าในคอลัมน์นั้น; แท็บที่ไม่มีคอลัมน์ที่มา ต้องมีรายการใน `18_Change_Log` ที่มีช่องที่มาสำหรับแถวนั้น
3. **รหัสและการอ้างอิงข้ามแท็บ**
   - รหัสไม่ซ้ำในแท็บของตัวเอง และตรง pattern (`FLOW-Axx-nnn`, `SCR-Axx-nnn-nn`, `TR-Axx-nnn`, `TC-Axx-nnn`, `DOC-nnn`, `TD-nnn`, `ISS-nnn`, `CHG-nnn`)
   - รหัสที่อ้างถึงต้องมีอยู่จริง: Flow ID, Primary Screen Seq ID, Screen Seq ID, Previous/Next Screen, From/To Screen Seq ID, Transition Ref, Test Case ID, Test Data ID, Related Test Case ID
   - ไม่มีการนำรหัสที่ถูกลบ (ตาม `18_Change_Log`) กลับมาใช้
   - **Hyperlink** (`Link to Flow`, `Link to Screen Sequence`, `Flow Link`): แยกแท็บ/แถวปลายทางจากสูตร HYPERLINK แล้วตรวจว่าแถวนั้นมีรหัส Flow ID / Screen Seq ID ตรงกับแถวต้นทาง และข้อความลิงก์ตรงกับรหัส (สำหรับ `Flow Link`)
4. **สูตร** — ทุกสูตรตาม pattern ใน CLAUDE.md ยังอยู่ครบทุกแถวข้อมูล, ไม่มี `#REF!` / ชื่อแท็บผิด / ช่วงอ้างอิงเพี้ยนจาก template, และค่าที่ cache ไว้ (ถ้ามี) ไม่เป็น error — ยกเว้นค่า cache "HYPERLINK is not implemented" ที่มาจาก template (ให้ตรวจจากตัวสูตรแทน)
5. **Dropdown** — ค่าทุกช่องที่มี data validation อยู่ในรายการที่อนุญาต (99_Lists หรือ inline list ของช่องนั้น) และ data validation / กรอบตาราง / ชื่อแท็บ / ลำดับคอลัมน์ ยังเหมือน template
6. **แถวที่ห้ามแก้** — เทียบกับไฟล์ล่าสุดใน `output/backup/`: แถว "ยืนยันแล้ว" (จับคู่ด้วยรหัส) ต้องไม่เปลี่ยนค่า และคอลัมน์ `Actual Result`, `Test Result`, `Step Result`, `Defect ID` ต้องไม่เปลี่ยนค่า ถ้าไม่มีไฟล์ backup ให้รายงานว่าข้ามข้อนี้

## รายงาน
- ตารางสรุป: ข้อ | ผ่าน/ไม่ผ่าน | จำนวนรายการที่ไม่ผ่าน
- รายการที่ไม่ผ่านทั้งหมด: ข้อ | แท็บ | แถว | รหัส | คอลัมน์ | ปัญหา | ข้อเสนอแก้
- ห้ามแก้เอง ให้ผู้ใช้ตัดสินใจว่าจะแก้ผ่าน `/ecmis-update` หรือเปิด Open Issue
