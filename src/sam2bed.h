#include<string>
#include<fstream>
class SamToBed
{
private:
  char * ifilePath;
  char * ofilePath;

public:
  SamToBed(char * ifilePath, char * ofilePath);
  int sam2bed();
  int sam2bed_merge(int pos_offset=4,int neg_offset=-5,char ** chrList = NULL,int char_filter_size = 0,
                    bool sort = true,bool unique = true,int min_freg_len=0, int max_freg_len=100, bool save_ext_len=false);
private:
    int getReadsLen(char * CIGAR);
};
