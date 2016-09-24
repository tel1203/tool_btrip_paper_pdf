require "prawn"
require 'prawn/measurement_extensions'


def make_pdf(pos, d1_y, d1_m, d1_d, d1_hh, d1_mm, d2_y, d2_m, d2_d, d2_hh, d2_mm, reason, flag_go=false, flag_back=false)
dd=Time.now
d0_y=sprintf("%04d", dd.year)
d0_m=sprintf("%02d", dd.month)
d0_d=sprintf("%02d", dd.day)

wdays = ["日", "月", "火", "水", "木", "金", "土"]
f_name = sprintf("%s%s%s_%s%s.pdf", d1_y, d1_m, d1_d, d1_hh, d1_mm)
offset = pos.to_i*80

d1=Time.local(d1_y, d1_m, d1_d)
d2=Time.local(d2_y, d2_m, d2_d)

Prawn::Document.generate(f_name, page_size: 'A4', margin: [15.mm, 15.mm, 20.mm, 25.mm]) do |pdf|

  pdf.font_families.update('ipa-mincho' => {normal: {file: 'ipaexm.ttf'}})
  # フォントの設定
  pdf.font('ipa-mincho')
  pdf.font_size(12)

#  for i in 0..39 do
#    x=i*5
#    s=(i%10).to_s
#    pdf.text_box(s, at: [x.mm, 230.mm], width: 10.mm, height: 10.mm)
#  end
#  for i in 0..39 do
#    y=230-i*5
#    s=(i%10).to_s
#    pdf.text_box(s, at: [0.mm, y.mm], width: 10.mm, height: 10.mm)
#  end

  # 記載日
  height=235-offset
  d0_x0=12
  d0_x1=28
  d0_x2=40
  pdf.text_box(d0_y, at: [d0_x0.mm, height.mm], width: 20.mm, height: 10.mm)
  pdf.text_box(d0_m, at: [d0_x1.mm, height.mm], width: 20.mm, height: 10.mm)
  pdf.text_box(d0_d, at: [d0_x2.mm, height.mm], width: 20.mm, height: 10.mm)

  # 直行・直帰
  height=214-offset
  pdf.stroke_ellipse([43.mm,height.mm],11.mm,3.mm) if (flag_go=="true")
  pdf.stroke_ellipse([66.mm,height.mm],11.mm,3.mm) if (flag_back=="true")

  # 出張日
  height=207-offset
  pdf.text_box(d1_y, at: [12.mm, height.mm], width: 20.mm, height: 10.mm)
  pdf.text_box(d1_m, at: [28.mm, height.mm], width: 20.mm, height: 10.mm)
  pdf.text_box(d1_d, at: [40.mm, height.mm], width: 20.mm, height: 10.mm)
  pdf.text_box(wdays[d1.wday], at: [52.mm, height.mm], width: 10.mm, height: 10.mm)
  pdf.text_box(d1_hh, at: [67.mm, height.mm], width: 10.mm, height: 10.mm)
  pdf.text_box(d1_mm, at: [75.mm, height.mm], width: 10.mm, height: 10.mm)

  pdf.text_box(d2_y, at: [95.mm, height.mm], width: 20.mm, height: 10.mm)
  pdf.text_box(d2_m, at: [111.mm, height.mm], width: 20.mm, height: 10.mm)
  pdf.text_box(d2_d, at: [123.mm, height.mm], width: 20.mm, height: 10.mm)
  pdf.text_box(wdays[d2.wday], at: [135.mm, height.mm], width: 10.mm, height: 10.mm)
  pdf.text_box(d2_hh, at: [150.mm, height.mm], width: 10.mm, height: 10.mm)
  pdf.text_box(d2_mm, at: [158.mm, height.mm], width: 10.mm, height: 10.mm)

  # 出張理由
  height=196-offset
  pdf.text_box(reason, at: [10.mm, height.mm], width: 156.mm, height: 25.mm)

  pdf.stroke
end
 
end

pos=ARGV[0]
d1_y=ARGV[1] 
d1_m=ARGV[2]
d1_d=ARGV[3]
d1_hh=ARGV[4]
d1_mm=ARGV[5]

d2_y=ARGV[6]
d2_m=ARGV[7]
d2_d=ARGV[8]
d2_hh=ARGV[9]
d2_mm=ARGV[10]

reason=ARGV[11]
flag_go=ARGV[12]
flag_back=ARGV[13]

make_pdf(pos, d1_y, d1_m, d1_d, d1_hh, d1_mm, d2_y, d2_m, d2_d, d2_hh, d2_mm, reason, flag_go, flag_back)
exit

pos=0
d1_y="2015" 
d1_m="07" 
d1_d="10" 
d1_hh="07"
d1_mm="00"

d2_y="2015" 
d2_m="07" 
d2_d="11" 
d2_hh="21"
d2_mm="00"

reason="（専門活動）日欧センサーネットワーク共同研究の国内チームの月例ミーティングに参加する。ミーティングは、大阪梅田のグランフロント大阪北館9F（大阪市北区）にて実施する。/ 夕方からもミーティングがあるので継続して滞在する。"

make_pdf(pos, d1_y, d1_m, d1_d, d1_hh, d1_mm, d2_y, d2_m, d2_d, d2_hh, d2_mm, reason)
#make_pdf(1, d1_y, d1_m, d1_d, d1_hh, d1_mm, d2_y, d2_m, d2_d, d2_hh, d2_mm, reason)
#make_pdf(2, d1_y, d1_m, d1_d, d1_hh, d1_mm, d2_y, d2_m, d2_d, d2_hh, d2_mm, reason)
