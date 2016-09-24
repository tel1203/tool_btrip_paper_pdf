require "prawn"
require 'prawn/measurement_extensions'


def make_pdf(f_name, items)
  # 記載日
  dd=Time.now
  d0_y=sprintf("%04d", dd.year)
  d0_m=sprintf("%02d", dd.month)
  d0_d=sprintf("%02d", dd.day)
  
  wdays = ["日", "月", "火", "水", "木", "金", "土"]
#  f_name = sprintf("%s%s%s_%s%s.pdf", d1_y, d1_m, d1_d, d1_hh, d1_mm)
  
  Prawn::Document.generate(f_name, page_size: 'A4', margin: [15.mm, 15.mm, 20.mm, 25.mm]) do |pdf|
  
    items.each do |item|
      pos = item[0]
      d1_y = item[1]
      d1_m = item[2]
      d1_d = item[3]
      d1_hh = item[4]
      d1_mm = item[5]
      d2_y = item[6]
      d2_m = item[7]
      d2_d = item[8]
      d2_hh = item[9]
      d2_mm = item[10]
      flag_go = item[11]
      flag_back = item[12]
      reason = item[13]
  
      # Output for 1 item
      offset = pos.to_i*80
    
      d1=Time.local(d1_y, d1_m, d1_d)
      d2=Time.local(d2_y, d2_m, d2_d)
    
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
    end
    
    pdf.stroke
  end
 
end

fname = ARGV[0]
fname_pdf = fname.match(/.*(?=\.)/).to_s+".pdf"
printf("DATA: [%s]  PDF: [%s]\n", fname, fname_pdf)

f = open(fname, "r")
items = Array.new
while ((line = f.gets) != nil) do
  tmp = line.split(" ")
  break if (tmp == nil or tmp.size < 13)
  reason = tmp[13..-1].join().gsub('"', '')
  data = tmp[0..12] + [reason]
  p data
  items.push(data)
end

make_pdf(fname_pdf, items)

