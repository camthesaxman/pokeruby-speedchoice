CXX := g++

CXXFLAGS := -std=c++11 -O2 -Wall -Wno-switch

SRCS := agb.cpp error.cpp main.cpp midi.cpp tables.cpp

HEADERS := agb.h error.h main.h midi.h tables.h

.PHONY: clean

mid2agb: $(SRCS) $(HEADERS)
	$(CXX) $(CXXFLAGS) $(SRCS) -o $@

clean:
	$(RM) mid2agb mid2agb.exe
