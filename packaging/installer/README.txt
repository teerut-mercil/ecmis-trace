ECMIS skill — วิธีติดตั้ง
========================

ในไฟล์ zip นี้มี
  skill/ecmis/          skill /ecmis (ตัวติดตั้งจะคัดลอกไปไว้ที่ ~/.claude/skills/ecmis)
  project/ecmis-trace/  โฟลเดอร์โปรเจกต์ตั้งต้น (กติกา CLAUDE.md, template Excel, โฟลเดอร์ว่าง)
  install.cmd           ตัวติดตั้งสำหรับ Windows (ดับเบิลคลิก)
  install.ps1           ตัวติดตั้งสำหรับ Windows (install.cmd เรียกไฟล์นี้)
  install.sh            ตัวติดตั้งสำหรับ macOS

1) ติดตั้ง skill
   Windows : แตกไฟล์ zip แล้วดับเบิลคลิก install.cmd
   macOS   : แตกไฟล์ zip แล้วเปิด Terminal ในโฟลเดอร์นั้น พิมพ์
               bash install.sh

   - ถ้าเคยติดตั้ง skill ecmis ไว้แล้ว ของเดิมจะถูกสำรองไว้ที่ ~/.claude/skill-backups/
   - ถ้าเครื่องมี Python 3.10 ขึ้นไป ตัวติดตั้งจะติดตั้งตัวแปลงเอกสาร (markitdown) ให้ด้วย
     ถ้ายังไม่มี Python ให้ติดตั้งจาก https://www.python.org/downloads/ แล้วรันตัวติดตั้งอีกครั้ง
     (Windows: ติ๊ก "Add python.exe to PATH" ตอนติดตั้ง Python)

2) เตรียมโปรเจกต์
   คัดลอกโฟลเดอร์ project/ecmis-trace ไปไว้ที่ที่ต้องการ แล้ววางเล่มเอกสารใน ecmis-trace/input/docs/

3) ใช้งาน
   เปิด Claude Code ในโฟลเดอร์ ecmis-trace แล้วสั่ง
     /ecmis 5
   (เปลี่ยน 5 เป็นเลข Activity ที่ต้องการ) — ถ้า Claude Code เปิดอยู่ก่อนติดตั้ง ให้ปิดแล้วเปิดใหม่

ถอนการติดตั้ง: ลบโฟลเดอร์ ~/.claude/skills/ecmis
  (Windows: %USERPROFILE%\.claude\skills\ecmis)
