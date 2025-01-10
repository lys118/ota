package ota.model.dto;

public class PageDto {
	private int listCount; //전체 글 갯수
	private int listSize; //페이지당 목록수 (한 페이지당 글이 몇개?)
	private int pageBarSize; //페이지바의 페이지 갯수 (보통 10)
	private int currentPage; //현재페이지
	private int maxPage;//최대 페이지수(끝페이지) ex)35
	private int beginPage;//시작페이지 ex) 1
	private int endPage;//마지막페이지 ex) 10
	private int startList;//db조회를 위한 시작글 번호
	private int endList;//db조회를 위한 마지막글 번호
	
	public PageDto() {}
	
	public PageDto(int listsize, int pageBarSize, int listcount, int currentpage) {
		this.listSize = listsize;
		this.pageBarSize = pageBarSize;
		this.listCount = listcount;
		this.currentPage = currentpage;
		
		//구해야 하는값 5개
		setMaxPage(); 
		setBeginPage();
		setEndPage();
		setStartList();
		setEndList();
	}

	private void setMaxPage() {
		this.maxPage =listCount / listSize; 
		// 최대페이지수는 전체글 / 페이지당목록수 ex) 35개글에 목록당글수 10개면 35/10 로 3이나온다
		// 하지만 글이 35개면 4페이지이다. 30개면 3페이지까지이고.
		// 1페이지 1~10 2페이지 11~20 
		// 3페이지 21~30 4페이지 31~40
		// 그러므로 아래에서 35 % 10을 해서 나머지가 있을경우엔
		if(listCount % listSize > 0)
			this.maxPage++; //최대페이지수를 +1페이지를 해준다.
	}

	private void setBeginPage() {
		this.beginPage = (currentPage/pageBarSize) * pageBarSize +1;
		//beginPage는 페이지바에 보여줄 시작번호를 뜻한다.
		//시작페이지는 현재페이지/페이지갯수를 나누고 페이지갯수를 곱한거의+1 
		//ex)1페이지는 1/10*10+1=1, 3페이지도 1
		//현재페이지(currentPage)가 3페이지(글목록21~30번)을 보고 있어도
		//페이지바에 보여줄 시작번호는 1번이다.
		//근데 10페이지도 페이지바안에 1로 나와야함 1~10이므로
		//하지만 10/10*10+1은 11이나온다 그러므로
		if(currentPage % pageBarSize ==0) 
			this.beginPage -=pageBarSize; 
		// 현재페이지 % 페이지사이즈 가 0일경우 10,20..페이지이면 10을뺴주면 1 11, 21,....이나온다
	}

	private void setEndPage() {
		this.endPage = beginPage+(pageBarSize-1);
		//페이지바의의 마지막번호는 시작페이지번호에서 페이지목록크기-1하고 더해준다
		//ex)10 = 1+10-1
		//근데 마지막페이지가 20이나왓는데 최대페이지가 15가나오면
		if(this.endPage>maxPage)
			this.endPage=maxPage; //최대페이지로 바꾸어준다
	}

	private void setStartList() {
		//마지막으로 db에서 조회할 글번호 ex)현재페이지 3이면
		//시작(글목록맨위)은 (3*10) - 9 = 21번글 부터 조회해서
		this.startList = (currentPage * listSize)-(listSize-1);
	}

	private void setEndList() {
		this.endList = currentPage * listSize;
		//마지막글 30*10 = 30번글까지 조회
	}

	public int getListCount() {
		return listCount;
	}

	public int getListSize() {
		return listSize;
	}

	public int getPageBarSize() {
		return pageBarSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public int getBeginPage() {
		return beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getStartList() {
		return startList;
	}

	public int getEndList() {
		return endList;
	}
	
	
	
	
	
	

	
	
	

	
}
