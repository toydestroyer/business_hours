class Store < ActiveRecord::Base
  def business_hours
    arr = [[[self.mon_open, self.mon_close]]]
    cur = 0
    [[self.tue_open, self.tue_close], [self.wed_open, self.wed_close], [self.thu_open, self.thu_close], [self.fri_open, self.fri_close], [self.sat_open, self.sat_close], [self.sun_open, self.sun_close]].each do | i |
      if i === arr[cur][0]
        arr[cur].push(i)
      else
        cur = cur + 1
        arr[cur] = []
        arr[cur].push(i)
      end
    end

    d = ['пн.', 'вт.', 'ср.', 'чт.', 'пт.', 'сб.', 'вс.']

    f = 0
    h = {}

    arr.each do | i |
      if i.count === 1
        h["#{d[(f=f+i.count)-1]}"] = i[0]
      else
        h["#{d[f]}-#{d[(f=f+i.count)-1]}"] = i[0]
      end
    end

    s = ""

    h.each do | i, k |
      hours = k[0].nil? ? "выходной" : "#{k[0].to_s(:time)}-#{k[1].to_s(:time)}"
      s << "#{i}: #{hours}<br>"
    end

    return s

  end
end

