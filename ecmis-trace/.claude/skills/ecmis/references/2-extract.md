# ขั้น 2 — สกัดข้อมูล

สกัดข้อมูลของ Activity ที่ระบุจาก work/docs ลง work/extract/A{เลข}_extract.md พร้อมเลขหน้าทุกรายการ

Activity: **{Activity}**

## ขอบเขต
- **ห้ามแตะไฟล์ Excel ใด ๆ** — อ่านได้เฉพาะ template เพื่อดูหัวคอลัมน์ และ output (ถ้ามี) เพื่อดูรหัสเดิม
- ใช้เฉพาะข้อมูลใน `work/docs/` เป็นแหล่ง ถ้ายังไม่มี ให้กลับไปทำขั้น 1 ก่อน

## ขั้นตอน
1. เปิด `work/docs/_index.md` หาเล่มและช่วงหน้า/หัวข้อที่เกี่ยวกับ Activity {Activity}
2. อ่านหัวคอลัมน์จากแถว 5 ของทุกแท็บใน template เพื่อให้หัวข้อที่สกัดครบตามที่ template ต้องการ
3. ถ้ามีไฟล์ output แล้ว ให้อ่านรหัสเดิมของ Activity นี้ (FLOW/SCR/TR/TC/DOC/TD/ISS) มาอ้างอิง เพื่อจับคู่รายการกับรหัสเดิม — ห้ามตั้งรหัสใหม่ในไฟล์นี้ ให้ใช้ `NEW-1`, `NEW-2`, … สำหรับรายการที่ยังไม่มีรหัส
4. สกัดข้อมูลลง `work/extract/A{เลข 2 หลัก}_extract.md` (เช่น `A05_extract.md`) แบ่งหัวข้อตามแท็บ:
   - 01 ภาพรวม Activity / 02 AS-IS–TO-BE / 03 ใครทำอะไร
   - 04 Main Flow (ทุก Step: ผู้ดำเนินการ, Input, Process, Decision, Forward, Return/Rework, Exit/Handoff, Output, SLA, Evidence)
   - 05 Supporting Flow / 06 จุดเชื่อม / 07 Gap-Feature / 08 Feature / 09 Permission
   - 11 Process Step Detail (LAW / Function No., SDD ID, Page Code, Actor, Trigger, Precondition, Input, ปุ่ม, Business Logic, Validation, Decision, Next LAW, Return Path, Output Doc/Status, Notification, Audit, Permission, Expected Result)
   - 11 Screen Sequence (หน้าจอตามลำดับ, ปุ่ม, หน้าจอถัดไปทั้ง Forward และ Return)
   - 12 Document Matrix / 13 LAW Transition
   - 14–15 Test Case และ Test Steps ที่ต้องมี (Happy Path, Negative, Return/Rework ต่อทุก Decision) / 17 Test Data
5. **ทุกรายการต้องมีที่มา** ตามวิธีอ้างอิงของเล่มใน `_index.md`: `[เล่ม น.xx]` (PDF), `[เล่ม สไลด์ xx]` (PPTX), `[เล่ม §หัวข้อ]` (DOCX ฯลฯ) — ข้อมูลที่มาจากหน้า `[อ่านจากภาพ]` ให้ติดป้าย `[อ่านจากภาพ]` ต่อท้ายที่มา
6. เทียบกับข้อมูลร่างเดิมในไฟล์ output/template (สถานะ Draft) และระบุผลต่อรายการ: `ตรงเล่ม` / `ไม่ตรงเล่ม (ค่าเล่ม: …)` / `ไม่พบในเล่ม`
7. ท้ายไฟล์ทำหัวข้อ **"รายการคำถาม"** สำหรับสิ่งที่หาไม่เจอหรือเล่มขัดกันเอง ระบุ: แท็บ/ช่องที่ขาด, คำถามที่ต้องให้ผู้รู้ตอบ, หน้า/หัวข้อที่ค้นแล้ว
8. **ห้ามเดา** ช่องที่หาไม่เจอให้เขียนว่า `— ไม่พบ —` แล้วยกไปรายการคำถาม
9. รายงานผู้ใช้: สรุปจำนวน Step/หน้าจอ/Transition/Test Case ที่สกัดได้, จำนวนรายการคำถาม, รายการที่ไม่ตรงกับร่างเดิม แล้วไปจุดตรวจ 1 ใน SKILL.md
