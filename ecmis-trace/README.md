# ecmis-trace

เติมและอัปเดต E-CMIS Master Activity Template จากเล่มเอกสารและ source code ทีละ Activity
กติกาทั้งหมดอยู่ใน `CLAUDE.md`

## วางไฟล์ไว้ที่ไหน

| โฟลเดอร์ | ใส่อะไร |
|---|---|
| `input/docs/` | เล่มเอกสาร (PDF / DOCX ฯลฯ) — แหล่งความจริงหลัก |
| `input/code/` | source code หรือไฟล์ข้อความที่ระบุ path ไป repo |
| `template/` | template ต้นฉบับ (วางไว้แล้ว **ห้ามแก้**) |

โฟลเดอร์ที่ระบบสร้างเอง: `work/docs/` (เล่มแปลงเป็นข้อความ), `work/extract/` (ข้อมูลราย Activity), `output/` (ไฟล์ส่งมอบไฟล์เดียว), `output/backup/` (สำรองก่อนแก้ทุกครั้ง)

## ลำดับการใช้คำสั่ง (ตัวอย่าง Activity 5)

```
/ecmis-prepare        แปลงเล่มเป็นข้อความพร้อมเลขหน้า (ทำครั้งเดียว หรือเมื่อมีเล่มใหม่)
/ecmis-extract 5      สกัดข้อมูล Activity 5 → work/extract/A05_extract.md
(ตรวจไฟล์ extract)    อ่านและแก้/ตอบรายการคำถามก่อนไปต่อ
/ecmis-verify 5       เทียบกับโค้ด → work/extract/A05_verify.md
/ecmis-update 5       สรุปรายการเพิ่ม/แก้/ลบให้ยืนยัน → เขียนไฟล์ output → รัน /ecmis-check อัตโนมัติ
```

`/ecmis-check 5` รันแยกได้ทุกเมื่อเพื่อตรวจไฟล์ output (อ่านอย่างเดียว)

## ไฟล์ส่งมอบ

`output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx` — มีไฟล์เดียว การเปลี่ยนแปลงทุกครั้งบันทึกในแท็บ `18_Change_Log`
